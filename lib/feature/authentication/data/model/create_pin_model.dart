class CreatePinState {
  final String setPin;
  final String confirmPin;

  CreatePinState({this.setPin = '', this.confirmPin = ''});

  bool get isValid =>
      setPin.length == 4 && confirmPin.length == 4 && setPin == confirmPin;

  CreatePinState copyWith({String? setPin, String? confirmPin}) {
    return CreatePinState(
      setPin: setPin ?? this.setPin,
      confirmPin: confirmPin ?? this.confirmPin,
    );
  }
}
