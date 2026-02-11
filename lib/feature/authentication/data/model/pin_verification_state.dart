class PinVerificationState {
  final String userPin;
  final String localPin;

  PinVerificationState({this.localPin = '', this.userPin = ''});

  PinVerificationState copyWith({String? userPin, String? localPin}) {
    return PinVerificationState(
      localPin: localPin ?? this.localPin,
      userPin: userPin ?? this.userPin,
    );
  }

  bool get isMatched =>
      userPin.isNotEmpty && localPin.isNotEmpty && userPin == localPin;
}
