import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shop_mitra/core/constants/api_key.dart';
import 'package:shop_mitra/core/exceptions/app_exceptions.dart';
import 'package:shop_mitra/core/network/api_endpoints.dart';
import 'package:shop_mitra/feature/authentication/data/model/auth_model.dart';
import 'package:shop_mitra/feature/authentication/data/model/login_model.dart';

import '../../../../core/network/api_client.dart';

abstract class LoginDataSource{
  Future<AuthModel> userLogin({required LoginModel loginModel});
}

class LoginDataSourceImpl implements LoginDataSource{
  final ApiClient client;

  LoginDataSourceImpl(this.client);
  @override
  Future<AuthModel> userLogin({required LoginModel loginModel}) async{
    final loginData = {
      "email":loginModel.email,
      "password":loginModel.password,
      "returnSecureToken":loginModel.returnSecureToken
    };
    try {
      final response = await client.post("${ApiEndpoints.firebaseSignInUrl}$apiKey",loginData);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        //debugPrint("login res :${response.body}");
        final authModel = AuthModel.fromJson(jsonData);
        return authModel;
      } else {
        throw AppException(
          "Server error: ${response.statusCode}",
        );
      }
    } on AppException {
      rethrow; // keep original exception
    } catch (e) {
      throw AppException("Unexpected error: $e");
    }
  }

}