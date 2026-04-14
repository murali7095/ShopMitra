import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';
import 'package:shop_mitra/core/hive/auth_data/user_data/get_user_details.dart';
import 'package:shop_mitra/core/hive/auth_data/user_data/save_user_details.dart';
import 'package:shop_mitra/core/hive/auth_data/user_model.dart';
import 'package:shop_mitra/feature/authentication/data/model/login_model.dart';
import 'package:shop_mitra/feature/authentication/domain/entitites/auth_entity.dart';
import 'package:shop_mitra/feature/authentication/presentation/controllers/login_dependencies.dart';

import 'auth_controller.dart';



final togglePassword = StateProvider<bool>((ref) {
  return true;
});
final toggleRememberMe = StateProvider<bool>((ref) {
  return true;
});

final mobileErrorMessage = StateProvider<String?>((ref) => null);
final emailErrorMessage = StateProvider<String?>((ref) => null);
final passwordErrorMessage = StateProvider<String?>((ref) => null);

bool isLoggedIn(String token) => token.isNotEmpty;



// Auth provider for managing the state

//final authBox =   Hive.box("authBox");
final authBoxProvider = Provider((ref) => Hive.box("authBox"),);
final userDetailsProvider = Provider<UserDetails>((ref) => UserDetails(authBox: ref.read(authBoxProvider)),);
final bootstrapAuthProvider = FutureProvider<void>((ref) async {
  final userDetails = ref.read(userDetailsProvider);
  final token = await userDetails.getToken();
  ref.read(authTokenProvider.notifier).state = token;
});


final authTokenProvider = StateProvider<String>((ref) {
  final box = Hive.box('authBox');
  return box.get('token', defaultValue: '') as String;
});

/*final appInstallationStatusProvider = StateProvider<bool>((ref) {
  final pinBox = Hive.box('pinBox');

  // Get 'isJustInstalled' key, default to false
  final isJustInstalled = pinBox.get('isJustInstalled', defaultValue: false) as bool;

  return isJustInstalled;
});*/

final authenticationControllerProvider =
AsyncNotifierProvider<
    AuthenticationController,
    AuthEntity?>(
  AuthenticationController.new,
);

final loginModelProvider = StateProvider<LoginModel?>(
      (ref) => null,
);

class AuthenticationController
    extends AsyncNotifier<AuthEntity?> {

  @override
  Future<AuthEntity?> build() async {
    // Initial state → no login yet
    return null;
  }

  /// Explicit user action
  Future<void> login() async {
    final loginModel = ref.read(loginModelProvider);

    if (loginModel == null) {
      state = AsyncError(
        StateError('LoginModel not set'),
        StackTrace.current,
      );
      return;
    }

    state = const AsyncLoading();

    final result = await ref
        .read(loginUserProvider)
        .loginUser(loginModel: loginModel);

    state = await result.fold(
          (l) => AsyncError(l.message, StackTrace.current),
          (loginEntity) async {
        final authBox = Hive.box("authBox");

        final userModel = UserModel(
          localId: loginEntity.localId,
          email: loginEntity.email,
          displayName: loginEntity.email,
          idToken: loginEntity.idToken,
          registered: loginEntity.registered,
          expiresIn: loginEntity.expiresIn,
          refreshToken: loginEntity.refreshToken,
        );

        final saveUserDetails =
        SaveUserDetails(userModel: userModel, authBox: authBox);

        await saveUserDetails.saveToken();
        await saveUserDetails.saveEmail();
        await saveUserDetails.saveRefreshToken();
        await saveUserDetails.saveExpireTime();

        ref.read(authTokenProvider.notifier).state =
            userModel.idToken;
        ref.read(authProvider.notifier).setToken(userModel.idToken);


        return AsyncData(loginEntity);
      },
    );
  }
}



/*final authProvider =
StateNotifierProvider<AuthNotifier, AsyncValue<AuthEntity?>>(
      (ref) => AuthNotifier(ref),
);*/

/*// AuthNotifier for managing login state
class AuthNotifier extends StateNotifier<AsyncValue<AuthEntity?>> {
  final Ref _ref;

  AuthNotifier(this._ref) : super(const AsyncValue.data(null));
  Future<void> login(LoginModel loginModel) async {
    final useCase = _ref.read(loginUserProvider);
    state = const AsyncValue.loading();

    final result = await useCase.loginUser(loginModel: loginModel);

    result.fold(
          (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
      },
          (loginEntity) async {
        state = AsyncValue.data(loginEntity);

        final authBox = Hive.box("authBox");
        final userModel = UserModel(
          localId: loginEntity.localId,
          email: loginEntity.email,
          displayName: loginEntity.email,
          idToken: loginEntity.idToken,
          registered: loginEntity.registered,
          expiresIn: loginEntity.expiresIn,
          refreshToken: loginEntity.refreshToken,
        );

        final saveUserDetails =
        SaveUserDetails(userModel: userModel, authBox: authBox);

        if (userModel.idToken.isNotEmpty) {
          await saveUserDetails.saveToken();
          await saveUserDetails.saveEmail();
          await saveUserDetails.saveRefreshToken();
          await saveUserDetails.saveExpireTime();

          // 🔥 THIS is what triggers navigation
          _ref.read(authTokenProvider.notifier).state = userModel.idToken;
        }
      },
    );
  }

}*/
