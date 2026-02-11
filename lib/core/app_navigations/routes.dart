import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_mitra/core/app_navigations/route_constants.dart';
import 'package:shop_mitra/feature/authentication/presentation/pin_code_login/create_pin_screen.dart';
import 'package:shop_mitra/feature/authentication/presentation/pin_code_login/pin_verification_screen.dart';
import 'package:shop_mitra/feature/dashboard/presentation/screens/dashboard_screen.dart';

import '../../feature/authentication/presentation/controllers/auth_controller.dart';
import '../../feature/authentication/presentation/screens/login_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: RouteConstants.loginRoute,

    redirect: (context, state) {
      final path = state.uri.path;

      final loggedIn = authState.isLoggedIn;
      final hasPin = authState.hasPin;

      final isLogin = path == RouteConstants.loginRoute;
      final isCreatePin = path == RouteConstants.createPinRoute;
      final isVerifyPin = path == RouteConstants.pinVerifyRoute;

      // 🚨 Not logged in
      if (!loggedIn) {
        return isLogin ? null : RouteConstants.loginRoute;
      }

      // 🔐 Logged in but no pin
      if (loggedIn && !hasPin) {
        return isCreatePin ? null : RouteConstants.createPinRoute;
      }

      // 🔒 Logged in + has pin
      if (loggedIn && hasPin) {
        if (isVerifyPin || path == RouteConstants.dashboardRoute) {
          return null;
        }
        return RouteConstants.pinVerifyRoute;
      }

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
      GoRoute(
        path: RouteConstants.pinVerifyRoute,
        builder: (_, __) => const PinVerificationScreen(),
      ),
      GoRoute(
        path: RouteConstants.dashboardRoute,
        builder: (_, __) => const DashboardScreen(),
      ),
    ],
  );
});





