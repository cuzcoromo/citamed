import 'package:citamed/providers/auth/login_provider.dart';
import 'package:citamed/providers/graphql_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'registro_medico_providers.g.dart';

@riverpod
Future<void> registrarDoctor(Ref ref, input) async {
  final client = await ref.watch(authenticatedGraphQLClientProvider.future);
  final loginState = ref.read(loginProvider);
  final user = loginState.user;

  final mutation = r'''
  mutation CreateDoctor ($input:DoctorInput!){
    createDoctor(data:$input){
      data{
      id
      attributes{
        nombre
        apellido
        email
        phone_number
        num_registro
      }
      }
    }
  }
  ''';

  final result = await client.mutate(
    MutationOptions(
      document: gql(mutation),
      variables: {'input': input.toMap()},
    ),
  );

  if (result.hasException) {
    throw result.exception!;
  }
}
