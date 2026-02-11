import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';
import 'package:shop_mitra/feature/authentication/data/model/create_pin_model.dart';
import 'package:shop_mitra/feature/authentication/data/model/pin_verification_state.dart';
final pinVerifiedProvider = StateProvider<bool>((ref) => false);

final pinVerificationProvider =
NotifierProvider<PinVerificationNotifier, PinVerificationState>(
    PinVerificationNotifier.new);

class PinVerificationNotifier
    extends Notifier<PinVerificationState> {

  @override
  PinVerificationState build() {
    final pinBox = Hive.box("pinBox");
    final localPin = pinBox.get("userPin", defaultValue: '');

    return PinVerificationState(
      localPin: localPin,
    );
  }

  void updateUserPin(String pin) {
    state = state.copyWith(userPin: pin);
  }

  bool get isMatched =>
      state.userPin.length == 4 &&
          state.userPin == state.localPin;

  void clear() {
    state = PinVerificationState(localPin: state.localPin);
  }
}


final createPinProvider = NotifierProvider<CreatePinNotifier,CreatePinState>(CreatePinNotifier.new,);

class CreatePinNotifier extends Notifier<CreatePinState> {
  @override
  CreatePinState build() {
    return CreatePinState();
  }

  void updateSetPin(String pin) {
    state = state.copyWith(setPin: pin);
  }

  void updateConfirmPin(String pin) {
    state = state.copyWith(confirmPin: pin);
  }

  void clear() {
    state = CreatePinState();
  }
}
