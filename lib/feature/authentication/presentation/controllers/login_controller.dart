import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';
import 'package:shop_mitra/core/hive/auth_data/user_data/get_user_details.dart';
import 'package:shop_mitra/core/hive/auth_data/user_data/save_user_details.dart';
import 'package:shop_mitra/core/hive/auth_data/user_model.dart';
import 'package:shop_mitra/feature/authentication/data/model/login_model.dart';
import 'package:shop_mitra/feature/authentication/domain/entitites/auth_entity.dart';
import 'package:shop_mitra/feature/authentication/domain/repositories/login_repository.dart';
import 'package:shop_mitra/feature/authentication/domain/usecases/login_usecases.dart';
import 'package:shop_mitra/feature/authentication/presentation/controllers/login_dependencies.dart';

import '../../data/repositoty/login_repo_impl.dart';



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
final authProvider =
StateNotifierProvider<AuthNotifier, AsyncValue<AuthEntity?>>(
      (ref) => AuthNotifier(ref),
);
//final authBox =   Hive.box("authBox");
final authBoxProvider = Provider((ref) => Hive.box("authBox"),);
final userDetailsProvider = Provider<UserDetails>((ref) => UserDetails(authBox: ref.read(authBoxProvider)),);
final bootstrapAuthProvider = FutureProvider<void>((ref) async {
  final userDetails = ref.read(userDetailsProvider);
  final token = await userDetails.getToken();
  ref.read(authTokenProvider.notifier).state = token;
});


final authTokenProvider = StateProvider<String>((ref) => '');

// AuthNotifier for managing login state
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

}
