import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_mitra/core/app_navigations/routes.dart';
import 'package:shop_mitra/feature/authentication/presentation/controllers/login_controller.dart';

import 'core/hive/hive_base.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await hiveAdapterRegistration();
  await Firebase.initializeApp();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //  READ THE ROUTER FROM PROVIDER
    final router = ref.watch(goRouterProvider);
    ref.watch(bootstrapAuthProvider);

    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}


