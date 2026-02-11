import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'auth_state.dart';

final authProvider =
NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

class AuthNotifier extends Notifier<AuthState> {

  late final Box _authBox;
  late final Box _pinBox;

  @override
  AuthState build() {
    _authBox = Hive.box('authBox');
    _pinBox = Hive.box('pinBox');

    final token = _authBox.get('token', defaultValue: '') as String;
    final userPin = _pinBox.get('userPin', defaultValue: '') as String;

    return AuthState(
      token: token,
      userPin: userPin,
    );
  }

  // 🔐 Save token
  Future<void> setToken(String token) async {
    await _authBox.put('token', token);
    state = state.copyWith(token: token);
  }

  // 🔑 Save PIN
  Future<void> setPin(String pin) async {
    await _pinBox.put('userPin', pin);
    state = state.copyWith(userPin: pin);
  }

  // 🚪 Logout
  Future<void> logout() async {
    await _authBox.clear();
    await _pinBox.clear();
    state = const AuthState();
  }
}
