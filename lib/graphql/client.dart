import 'package:citamed/core/index.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

// final String graphqlEndpoint = 'http://localhost:1337';

GraphQLClient getGraphQLClient(String path) {
  final String baseuRrl = ENV.apiUrl;
  final fullendpoint = '$baseuRrl/$path';
  final httplink = HttpLink(fullendpoint);
  return GraphQLClient(
    link: httplink,
    cache: GraphQLCache(store: InMemoryStore()),
  );
}

// todo logeado el usario
GraphQLClient getAuthenticatedClient(String token) {
  final String baseUrl = ENV.apiUrlGraphql;
  final httplink = HttpLink(baseUrl);

  final authLink = AuthLink(getToken: () async => 'Bearer $token');

  final link = authLink.concat(httplink);

  return GraphQLClient(link: link, cache: GraphQLCache(store: InMemoryStore()));
}
