class AuthState {
  final String token;
  final String userPin;

  const AuthState({
    this.token = '',
    this.userPin = '',
  });

  bool get isLoggedIn => token.isNotEmpty;
  bool get hasPin => userPin.isNotEmpty;

  AuthState copyWith({
    String? token,
    String? userPin,
  }) {
    return AuthState(
      token: token ?? this.token,
      userPin: userPin ?? this.userPin,
    );
  }
}
