import 'package:flutter_test/flutter_test.dart';
import 'package:shop_mitra/feature/authentication/data/model/login_model.dart';

void main() {
  final loginModel = LoginModel(email: "test@gmail.com", password: "test@123", returnSecureToken: true);
  test('should create LoginModel with valid values', () {
     expect(loginModel.email, "test@gmail.com");
     expect(loginModel.returnSecureToken, true);
  });
}