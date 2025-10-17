// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
//
//
// // A provider that exposes GoRouter instance
// final goRouterProvider = Provider<GoRouter>((ref) {
//   // Watch auth state (example: user logged in or not)
//   final loginState = ref.watch(loginViewModelProvider);
//
//   return GoRouter(
//     initialLocation: RouteNames.login,
//     refreshListenable: GoRouterRefreshStream(ref.watch(authStreamProvider)), // or use a custom notifier for auth state
//     routes: [
//       GoRoute(
//         path: RouteNames.login,
//         builder: (context, state) => const LoginView(),
//       ),
//       GoRoute(
//         path: RouteNames.home,
//         builder: (context, state) => const HomeView(),
//       ),
//     ],
//     redirect: (context, state) {
//       final loggedIn = loginState.status == LoginStatus.success; // example login state check
//       final loggingIn = state.subloc == RouteNames.login;
//
//       if (!loggedIn) return loggingIn ? null : RouteNames.login;
//       if (loggingIn) return RouteNames.home;
//       return null;
//     },
//   );
// });
