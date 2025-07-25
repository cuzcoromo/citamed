import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../graphql/client.dart';

part 'graphql_provider.g.dart';

// Cliente sin token (para login)
final graphQLClientProvider = Provider.family<GraphQLClient, String>((
  ref,
  path,
) {
  return getGraphQLClient(path);
});

//todo Cliente con token (para operaciones autenticadas)
// final authenticatedGraphQLClientProvider = FutureProvider<GraphQLClient>((
//   ref,
// ) async {
//   final storage = FlutterSecureStorage();
//   final token = await storage.read(key: 'token');
//   if (token == null) throw Exception('No token found');

//   // Usa la función de client.dart
//   return getAuthenticatedClient(token);
// });
@riverpod
Future<GraphQLClient> authenticatedGraphQLClient(Ref ref) async {
  final storage = FlutterSecureStorage();
  final token = await storage.read(key: 'token');
  if (token == null) throw Exception('No token found');

  return getAuthenticatedClient(token);
}
