// ← Configura Dio + interceptor

// import 'package:http/http.dart';
import 'package:citamed/core/index.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'auth_interceptor.dart';
import 'package:dio/dio.dart';

const String baseapiUrl = ENV.apiUrl;

Dio createDioClient() {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseapiUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      contentType: 'application/json',
    ),
  );
  dio.interceptors.add(AuthInterceptor(const FlutterSecureStorage()));
  return dio;
}
