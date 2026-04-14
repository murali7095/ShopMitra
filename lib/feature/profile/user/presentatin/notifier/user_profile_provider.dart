import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_mitra/feature/profile/user/data/data_source/user_data_source.dart';
import 'package:shop_mitra/feature/profile/user/data/repo_impl/user_repo_impl.dart';
import 'package:shop_mitra/feature/profile/user/domain/entity/user.dart';
import 'package:http/http.dart' as http;
import 'package:shop_mitra/feature/profile/user/domain/user_cases/fetch_user_details.dart';

import '../../../../../core/network/api_client.dart';
final httpClientProvider = Provider<http.Client>((ref) => http.Client());

final apiClientProvider = Provider<ApiClient>(
      (ref) => ApiClient(client: ref.read(httpClientProvider)),
);
final userDataSourceProvider = Provider<UserDataSourceImpl>(
      (ref) =>UserDataSourceImpl(client: ref.read(apiClientProvider)),
);
final userProfileRepoProvider = Provider<UserProfileRepoImpl>(
      (ref) => UserProfileRepoImpl(ref.read(userDataSourceProvider)),
);

final fetchUserProfileDetails = Provider<FetchUserDetails>(
      (ref) => FetchUserDetails(ref.read(userProfileRepoProvider)),
);

final userProfileProvider = AsyncNotifierProvider<UserProfileNotifier,UserProfile>(UserProfileNotifier.new);
class UserProfileNotifier extends AsyncNotifier<UserProfile>{
  @override
  Future<UserProfile> build() async{
   // try{
      final url ="https://firestore.googleapis.com/v1/projects/shop-mitra-3399f/databases/(default)/documents/app_ads/user_details";
      final data = await ref.read(fetchUserProfileDetails).fetchUserDetails(userDetailsUrl: url);
     return data.fold( (failure) => throw failure,  (user) {
        return user;
      },);
    // }catch(e){
    //   throw Left(e.toString());
    // }
  }

}