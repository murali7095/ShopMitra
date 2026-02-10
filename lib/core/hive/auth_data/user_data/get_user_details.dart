import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class UserDetails {
  final Box<dynamic> authBox;

  UserDetails({required this.authBox});
  Future<String> getToken() async{
    final token = await authBox.get("token",defaultValue: '');
    debugPrint("token in get User :${token}");
    return token;
  }
  Future<String> getEmail() async{
    final email = await authBox.get("email",defaultValue: '');
    return email;
  }
  Future<String> getRefreshToken() async{
    final refreshToken = await authBox.get("refreshToken",defaultValue: '');
    return refreshToken;
  }
}