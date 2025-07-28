import 'package:citamed/providers/graphql_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_login_providers.g.dart';

class Doctor {
  final String id;
  final String nombre;
  final String apellido;
  final String email;
  final String celular;

  Doctor({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.email,
    required this.celular,
  });

  factory Doctor.fromMap(Map<String, dynamic> map) {
    final attr = map['attributes'] ?? {};
    return Doctor(
      id: map['id'],
      nombre: attr['nombre'] ?? '',
      apellido: attr['apellido'] ?? '',
      email: attr['email'] ?? '',
      celular: attr['num_celular'] ?? '',
    );
  }
}

@riverpod
Stream<List<Doctor>> getListDoctors(Ref ref) async* {
  final client = ref.watch(graphQLClientProvider('graphql'));

  final getDoctors = gql('''
      # TODOS DOCTORES
      query{
        doctors{
          data{
            id
            attributes{
              nombre
              apellido
              email
              num_celular
            }
          }
        }
      }
''');

  final result = await client.query(QueryOptions(document: getDoctors));
  if (result.hasException) {
    throw result.exception!;
  }

  // data
  final data = result.data?['doctors']?['data'] as List<dynamic>?;
  if (data == null || data == []) {
    yield [];
    return;
  }

  final doctors = data.map((item) => Doctor.fromMap(item)).toList();
  yield doctors;
}
