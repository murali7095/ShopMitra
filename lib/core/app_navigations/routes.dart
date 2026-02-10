import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_mitra/core/app_navigations/loader_screen.dart';
import 'package:shop_mitra/core/app_navigations/route_constants.dart';

import '../../feature/authentication/presentation/controllers/login_controller.dart';
import '../../feature/authentication/presentation/screens/create_pin_screen.dart';
import '../../feature/authentication/presentation/screens/login_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final token = ref.watch(authTokenProvider);

  return GoRouter(
    initialLocation: RouteConstants.loginRoute,

    redirect: (context, state) {
      final path = state.uri.path;
      final loggedIn = token.isNotEmpty;
      final loggingIn = path == RouteConstants.loginRoute;

      if (!loggedIn && !loggingIn) return RouteConstants.loginRoute;
      if (loggedIn && loggingIn) return RouteConstants.createPinRoute;

      return null;
    },

    routes: [
      GoRoute(
        path: RouteConstants.loginRoute,
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteConstants.createPinRoute,
        builder: (_, __) => const CreatePinScreen(),
      ),
    ],
  );
});
