import 'package:hive_flutter/adapters.dart';

import 'auth_data/user_model.dart';

Future<void> hiveAdapterRegistration() async {
  await Hive.initFlutter() ;
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox("authBox");
  await Hive.openBox("pinBox");
}