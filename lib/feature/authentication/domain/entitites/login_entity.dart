class LoginEntity {
  final String accessToken;
  final String refreshToken;

  LoginEntity({required this.accessToken, required this.refreshToken});

  factory LoginEntity.fromJson(Map<String, dynamic> json) {
    return LoginEntity(
      accessToken: json['access_token'],
      refreshToken: json["refresh_token"],
    );
  }
}
