import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_mitra/core/app_navigations/routes.dart';
import 'package:shop_mitra/core/network/api_client.dart';
import 'package:shop_mitra/feature/authentication/presentation/controllers/login_controller.dart';
import 'package:shop_mitra/feature/authentication/presentation/widgets/landing_screen.dart';
import 'package:shop_mitra/feature/dashboard/data/data_source/dashboard_data_source.dart';

import 'core/hive/hive_base.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await hiveAdapterRegistration();
  await Firebase.initializeApp();
  final client = ApiClient();
  // final url ="https://firestore.googleapis.com/v1/projects/shop-mitra-3399f/databases/(default)/documents/app_ads/user_details";
  // //final data = {"name":"Murali Mohan Reddy", "address":"Hyderabad, India", "image":"https://i.pinimg.com/736x/e8/e6/41/e8e64141f4c0ae39c32f9701ccea9a2e.jpg"};
  // final data = await DashboardDataSourceImpl(client: client).
  // fetchAppAds(adsUrl:  url );
  //https://firestore.googleapis.com/v1/projects/shop-mitra-3399f/profile/user_profile
 // debugPrint("the main res: $data");
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
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home: LandingScreen(),
    // );
  }
}


