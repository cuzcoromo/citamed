import 'dart:async';
import 'dart:convert';

import 'package:citamed/core/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

//todo modelo para usuario logeuado
typedef UserInfo = ({String id, String username, String email});

enum LoginStatus { initial, loading, succes, error }

class LoginState {
  final LoginStatus status;
  final String? errorMessage;
  final UserInfo? user;

  const LoginState({
    this.status = LoginStatus.initial,
    this.errorMessage,
    this.user,
  });

  LoginState copyWith({
    LoginStatus? status,
    String? errorMessage,
    UserInfo? user,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      user: user ?? this.user,
    );
  }
}

//! PROVEEDOR
final loginProvider = StateNotifierProvider<LoginController, LoginState>(
  (ref) => LoginController(ref),
);

class LoginController extends StateNotifier<LoginState> {
  LoginController(this.ref) : super(const LoginState());

  final Ref ref;
  final _streamController = StreamController<void>.broadcast();

  Stream<void> get refreshStream => _streamController.stream;

  void _notifyListeners() {
    if (!_streamController.isClosed) _streamController.add(null);
  }

  Future<void> loginquery({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(status: LoginStatus.loading);
    _notifyListeners();

    // todo variable de entorno
    final String baseUrl = ENV.apiUrl;
    final url = '$baseUrl/api/auth/local'; // cambia IP o dominio

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'identifier': email, 'password': password}),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode != 200 || data['jwt'] == null) {
      state = state.copyWith(
        status: LoginStatus.error,
        errorMessage: data['error']?['message'] ?? 'Error al iniciar sesión',
      );
      _notifyListeners();
      return;
    }

    const storage = FlutterSecureStorage();
    await storage.write(key: 'token', value: data['jwt']);

    final user = data['user'];
    state = state.copyWith(
      status: LoginStatus.succes,
      user: (
        id: user['id'].toString(),
        username: user['username'],
        email: user['email'],
      ),
    );
    _notifyListeners();
  }

  void logout() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
    state = const LoginState();
    _notifyListeners();
  }

  // obtener data del usuario
  Future<void> loadUserFromStorage() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    if (token != null) {
      final String baseUrl = ENV.apiUrl;
      final url = '$baseUrl/api/users/me'; // endpoint típico en Strapi
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final user = jsonDecode(response.body);
        state = state.copyWith(
          status: LoginStatus.succes,
          user: (
            id: user['id'].toString(),
            username: user['username'],
            email: user['email'],
          ),
        );
        _notifyListeners();
      } else {
        state = const LoginState();
        _notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
}
