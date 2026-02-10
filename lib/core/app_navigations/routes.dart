import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_mitra/core/app_navigations/loader_screen.dart';

import '../../feature/authentication/presentation/controllers/login_controller.dart';
import '../../feature/authentication/presentation/screens/create_pin_screen.dart';
import '../../feature/authentication/presentation/screens/login_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final token = ref.watch(authTokenProvider);

  return GoRouter(
    initialLocation: '/login',

    redirect: (context, state) {
      final path = state.uri.path;
      final loggedIn = token.isNotEmpty;
      final loggingIn = path == '/login';

      if (!loggedIn && !loggingIn) return '/login';
      if (loggedIn && loggingIn) return '/create_pin';

      return null;
    },

    routes: [
      GoRoute(
        path: '/login',
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: '/create_pin',
        builder: (_, __) => const CreatePinScreen(),
      ),
    ],
  );
});
