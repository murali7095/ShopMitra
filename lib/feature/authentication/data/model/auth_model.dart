import 'package:shop_mitra/feature/authentication/domain/entitites/auth_entity.dart';

class AuthModel extends AuthEntity {
  const AuthModel({
    required super.idToken,
    required super.email,
    required super.refreshToken,
    required super.expiresIn,
    required super.localId,
    required super.registered,
  });

  factory AuthModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const AuthModel(
        idToken: '',
        email: '',
        refreshToken: '',
        expiresIn: '0',
        localId: '',
        registered: false,
      );
    }

    return AuthModel(
      idToken: json['idToken'] ?? '',
      email: json['email'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      expiresIn: json['expiresIn'] ?? '0',
      localId: json['localId'] ?? '',
      registered: json['registered'] ?? false,
    );
  }
}
