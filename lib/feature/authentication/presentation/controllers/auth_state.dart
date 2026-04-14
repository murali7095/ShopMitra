class AuthState {
  final String token;
  final String userPin;
  final bool hasSeenLanding;
  final bool isPinVerified;

  const AuthState({
    this.token = '',
    this.userPin = '',
    this.hasSeenLanding = false,
    this.isPinVerified = false,
  });

  /// Derived getters
  bool get isLoggedIn => token.isNotEmpty;
  bool get hasPin => userPin.isNotEmpty;

  AuthState copyWith({
    String? token,
    String? userPin,
    bool? hasSeenLanding,
    bool? isPinVerified,
  }) {
    return AuthState(
      token: token ?? this.token,
      userPin: userPin ?? this.userPin,
      hasSeenLanding:
      hasSeenLanding ?? this.hasSeenLanding,
      isPinVerified:
      isPinVerified ?? this.isPinVerified,
    );
  }

  @override
  String toString() {
    return 'AuthState('
        'token: $token, '
        'userPin: $userPin, '
        'hasSeenLanding: $hasSeenLanding, '
        'isPinVerified: $isPinVerified'
        ')';
  }
}
