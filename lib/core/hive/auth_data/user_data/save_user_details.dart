import 'package:hive/hive.dart';
import 'package:shop_mitra/core/hive/auth_data/user_model.dart';

class SaveUserDetails {
  final UserModel userModel;
  final Box<dynamic> authBox;

  SaveUserDetails({required this.userModel, required this.authBox});

  Future<void> saveToken() async {
    await authBox.put("token", userModel.idToken);
  }

  Future<void> saveEmail() async {
    await authBox.put("email", userModel.email);
  }

  Future<void> saveRefreshToken() async {
    await authBox.put("refreshToken", userModel.refreshToken);
  }

  Future<void> saveExpireTime() async {
    await authBox.put("expiresIn", userModel.expiresIn);
  }
}
