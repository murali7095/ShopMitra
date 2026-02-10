class LoginModel {
  final String email;
  final String password;
  final bool returnSecureToken;

  LoginModel({
    required this.email,
    required this.password,
    required this.returnSecureToken,
  });
}
