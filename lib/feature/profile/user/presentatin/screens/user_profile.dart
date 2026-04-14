import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_mitra/feature/profile/user/presentatin/notifier/user_profile_provider.dart';

class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final userProfile = ref.watch(userProfileProvider);
    return Scaffold(
      body:  userProfile.when(data:  (data) {
        return Center(child: Text(data.name));
      }, error:  (error, stackTrace) => Text(error.toString()), loading:  () => CircularProgressIndicator(),)
    );
  }
}
