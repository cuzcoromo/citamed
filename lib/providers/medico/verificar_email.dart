import 'package:citamed/providers/auth/login_provider.dart';
import 'package:citamed/providers/graphql_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

Future<bool> getEmailDoctor(
  Ref ref, {
  required String id,
  required String email,
}) async {
  final client = await ref.watch(authenticatedGraphQLClientProvider.future);

  final loginState = ref.read(loginProvider);
  final id = loginState.user?.id;

  if (id == null) {
    return false;
  }

  final getEmailDoctor = gql(r'''
  query GetEmailDoctor($id: ID!, $email: String!) {
    doctors(filters: {
      id: { eq: $id }
      email: { eq: $email }
    }) {
      data {
        id
        attributes {
          email
        }
      }
    }
  }
''');

  try {
    final result = await client.query(
      QueryOptions(
        document: getEmailDoctor,
        variables: {'id': id, 'email': email},
      ),
    );
    final data = result.data?['doctors']?['data'];
    if (data is List && data.isNotEmpty) {
      return true;
    } else {}
  } catch (e) {
    return false;
  }
  return false;
}
