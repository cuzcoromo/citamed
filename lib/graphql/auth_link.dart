// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';

// class GraphqlConfig {
//   final String endpoint;
//   GraphqlConfig({required this.endpoint});
//   final storage = FlutterSecureStorage();

//   GraphQLClient client() {
//     final httplink = HttpLink(endpoint);

//     final authLink = AuthLink(
//       getToken: () async {
//         final token = await storage.read(key: 'token');

//         // final prefs = await SharedPreferences.getInstance();
//         // final token = prefs.getString('token');
//         if (token != null && token.isNotEmpty) {
//           return 'Bearer $token';
//         }
//         return null;
//       },
//     );

//     final link = authLink.concat(httplink);
//     return GraphQLClient(
//       cache: GraphQLCache(store: InMemoryStore()),
//       link: link,
//     );
//   }
// }
