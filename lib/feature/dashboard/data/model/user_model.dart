import 'package:shop_mitra/feature/profile/user/domain/entity/user.dart';

class UserProfileModel extends UserProfile{
  UserProfileModel({required super.name, required super.address, required super.image});

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      name: json['fields']?['name']?['stringValue'] ?? '',
      address: json['fields']?['address']?['stringValue'] ?? '',
      image: json['fields']?['image']?['stringValue'] ?? '',
    );
  }
}