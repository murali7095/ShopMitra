import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:shop_mitra/feature/dashboard/data/model/user_model.dart';

import '../../../../../core/exceptions/app_exceptions.dart';
import '../../../../../core/network/api_client.dart';

abstract class UserDataSource {
  Future<UserProfileModel> fetchUserDetails({required String userDetailsUrl});
}

class UserDataSourceImpl implements UserDataSource {
  final ApiClient client;

  UserDataSourceImpl({required this.client});

  @override
  Future<UserProfileModel> fetchUserDetails({
    required String userDetailsUrl,
  }) async {
    try {
      final response = await client.get(otherUrl: userDetailsUrl, '');
      debugPrint("the res;${response.body}");
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final userModel = UserProfileModel.fromJson(jsonData);
        return userModel;
      } else {
        throw AppException("Server error: ${response.statusCode}");
      }
    } on SocketException {
      throw AppException("No Internet Connection");
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException("Unexpected error: $e");
    }
  }
}
