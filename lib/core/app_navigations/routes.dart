import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_mitra/core/app_navigations/route_constants.dart';
import 'package:shop_mitra/feature/authentication/presentation/controllers/login_controller.dart';
import 'package:shop_mitra/feature/authentication/presentation/pin_code_login/create_pin_screen.dart';
import 'package:shop_mitra/feature/authentication/presentation/pin_code_login/pin_verification_screen.dart';
import 'package:shop_mitra/feature/authentication/presentation/widgets/landing_screen.dart';
import 'package:shop_mitra/feature/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:shop_mitra/feature/profile/user/presentatin/screens/user_profile.dart';

import '../../feature/authentication/presentation/controllers/auth_controller.dart';
import '../../feature/authentication/presentation/screens/login_screen.dart';
final goRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: RouteConstants.appLandingRoute,

    redirect: (context, state) {
      final path = state.uri.path;

      final loggedIn = authState.isLoggedIn;
      final hasSeenLanding = authState.hasSeenLanding;
      final hasPin = authState.hasPin;
      final isPinVerified = authState.isPinVerified;

      final isLanding = path == RouteConstants.appLandingRoute;
      final isLogin = path == RouteConstants.loginRoute;
      final isCreatePin = path == RouteConstants.createPinRoute;
      final isVerifyPin = path == RouteConstants.pinVerifyRoute;

      /// 1️⃣ First install → only landing allowed
      if (!hasSeenLanding) {
        return isLanding ? null : RouteConstants.appLandingRoute;
      }

      /// 2️⃣ Not logged in → only login allowed
      if (!loggedIn) {
        return isLogin ? null : RouteConstants.loginRoute;
      }

      /// 3️⃣ Logged in but no PIN → only createPin allowed
      if (!hasPin) {
        return isCreatePin ? null : RouteConstants.createPinRoute;
      }

      /// 4️⃣ Has PIN but not verified → only verifyPin allowed
      if (!isPinVerified) {
        return isVerifyPin ? null : RouteConstants.pinVerifyRoute;
      }

      /// 5️⃣ Fully authenticated
      /// Block auth screens, allow everything else
      if (isLanding || isLogin || isCreatePin || isVerifyPin) {
        return RouteConstants.dashboardRoute;
      }

      /// Allow all other routes (like /user_profile)
      return null;
    },


    routes: [
      GoRoute(
        path: RouteConstants.appLandingRoute,
        builder: (_, __) => const LandingScreen(),
      ),
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
      GoRoute(
        path: RouteConstants.userProfileRoute,
        builder: (_, __) => const UserProfileScreen(),
      ),
    ],
  );
});





/*
1. If app just installed → landing
2. If not logged in → login
3. If logged in but no pin → create pin
4. If logged in + has pin but NOT verified yet → pin verify
5. After pin verified → allow everything

*/


