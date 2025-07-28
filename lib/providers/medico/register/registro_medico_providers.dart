import 'package:citamed/core/dio/dio_provider.dart';
import 'package:citamed/providers/auth/login_provider.dart';
import 'package:citamed/providers/graphql_provider.dart';
import 'package:citamed/providers/medico/verificar_email.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'registro_medico_providers.g.dart';

@riverpod
Future<void> registrarDoctor(Ref ref, input) async {
  // final client = await ref.watch(authenticatedGraphQLClientProvider.future);
  final dio = ref.read(dioProvider);
  final loginState = ref.read(loginProvider);

  final user = loginState.user;
  final id = user?.id;
  final String email = input['email'];
  final newData = {...input, "user": id};

  try {
    // verificar si exite correo
    final emailexist = await getEmailDoctor(ref, id: '$id', email: email);
    if (emailexist == true) {
      throw 'Email ya registrado';
    }

    final result = await dio.post('/api/doctors', data: {"data": newData});
    if (result.statusCode == 200) return;
  } catch (e) {
    if (e is String) {
      rethrow;
    }
    throw 'Error al registar';
  }

  // final mutation = r'''
  // mutation CreateDoctor ($input:DoctorInput!){
  //   createDoctor(data:$input){
  //     data{
  //     id
  //     attributes{
  //       nombre
  //       apellido
  //       email
  //       phone_number
  //       num_registro
  //     }
  //     }
  //   }
  // }
  // ''';

  // final result = await client.mutate(
  //   MutationOptions(
  //     document: gql(mutation),
  //     variables: {'input': input.toMap()},
  //   ),
  // );

  // if (result.hasException) {
  //   throw result.exception!;
  // }
}
