import 'package:flutter_test/flutter_test.dart';
import 'package:shop_mitra/feature/authentication/domain/entitites/auth_entity.dart';

void main() {
  test('should create AuthEntity with valid values', () {
      const authEntity = AuthEntity(idToken: "idToken", email: "test@gmail.com", refreshToken: "jhdvfsdhfjdfj", expiresIn: "232", localId: "ssdvfvds", registered: true);
      expect(authEntity, isA<AuthEntity>());
      expect(authEntity.email, "test@gmail.com");
   });
}