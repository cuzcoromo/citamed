import 'package:citamed/screens/app/citas/citas.dart';
import 'package:citamed/screens/app/main_scaffold.dart';
import 'package:citamed/screens/app/medico/register_doctor.dart';
import 'package:citamed/screens/app/medicos/medico_info.dart';
import 'package:citamed/screens/app/medicos/medicos_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:citamed/screens/app/home_screen.dart';
import 'package:citamed/screens/auth/login_screen.dart';
import 'package:citamed/screens/auth/register_screen.dart';
import 'package:citamed/screens/app/post_login.dart';
import 'package:citamed/helper/go_router_refresh_stream.dart';
import 'package:citamed/providers/auth/login_provider.dart';

// 📌 Lista de rutas públicas
const publicRoutes = ['/login', '/register', '/post-login'];

// 📌 Definimos las rutas
final appRoutes = <RouteBase>[
  GoRoute(path: '/post-login', builder: (context, state) => const PostLogin()),
  GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
  GoRoute(
    path: '/register',
    builder: (context, state) => const RegisterScreen(),
  ),
  ShellRoute(
    builder: (context, state, child) => MainScaffold(child: child),
    routes: [
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/medicos',
        builder: (context, state) => const MedicosScreen(),
      ),
      GoRoute(
        path: '/doc-info',
        builder: (context, state) => const MedicoInfo(),
      ),
      GoRoute(
        path: '/det-cita',
        builder: (context, state) => const CitaScreen(),
      ),
    ],
  ),
  GoRoute(
    path: '/re-medico',
    builder: (context, state) => const RegisterDoctor(),
  ),
];

//!  ValueNotifier que contiene RoutingConfig (incluye rutas y redirect)
final routingConfig = ValueNotifier<RoutingConfig>(
  RoutingConfig(
    routes: appRoutes,
    redirect: (context, state) {
      final container = ProviderScope.containerOf(context, listen: false);
      final loginState = container.read(loginProvider);
      final loggedIn = loginState.user != null;
      final goingToPublic = publicRoutes.contains(state.uri.path);

      if (!loggedIn && !goingToPublic) return '/post-login';
      if (loggedIn && goingToPublic) return '/home';
      return null;
    },
  ),
);

//todo  Proveedor del router
final routerProvider = Provider<GoRouter>((ref) {
  //  Escucha cambios de login y actualiza routingConfig
  ref.listen(loginProvider, (_, __) {
    routingConfig.value = routingConfig.value;
  });

  return GoRouter.routingConfig(
    routingConfig: routingConfig,
    initialLocation: '/post-login',
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(
      ref.watch(loginProvider.notifier).refreshStream,
    ),
  );
});
