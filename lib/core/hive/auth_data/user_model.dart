import 'package:hive/hive.dart';
part 'user_model.g.dart';
@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String localId;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String displayName;
  @HiveField(3)
  final String idToken;
  @HiveField(4)
  final bool registered;
  @HiveField(5)
  final String expiresIn;
  @HiveField(6)
  final String refreshToken;

  UserModel({
    required this.localId,
    required this.email,
    required this.displayName,
    required this.idToken,
    required this.registered,
    required this.expiresIn,
    required this.refreshToken,
  });
}
