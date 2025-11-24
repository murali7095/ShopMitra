


import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shop_mitra/feature/authentication/data/model/login_model.dart';
import 'package:shop_mitra/feature/authentication/domain/repositories/login_repository.dart';
import 'package:shop_mitra/feature/authentication/domain/usecases/login_usecases.dart';

import '../../data/repositoty/login_repo_impl.dart';
import '../../domain/entitites/login_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



// Auth provider for managing the state
final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<LoginEntity?>>(
      (ref) => AuthNotifier(ref),
);

final togglePassword = StateProvider<bool>((ref) {
  return true;
});
final toggleRememberMe = StateProvider<bool>((ref) {
  return true;
});

final mobileErrorMessage = StateProvider<String?>((ref) => null,);
final emailErrorMessage = StateProvider<String?>((ref) => null,);
final passwordErrorMessage = StateProvider<String?>((ref) => null,);


// Login Use Case Provider
final loginUseCaseProvider = Provider<LoginUseCase>(
      (ref) {
    final loginRepo = ref.read(loginRepositoryProvider);
    return LoginUseCase(loginRepo);
  },
);

// Login Repository Provider
final loginRepositoryProvider = Provider<LoginRepository>(
      (ref) => LoginRepoImpl(),
);


// AuthNotifier for managing login state
class AuthNotifier extends StateNotifier<AsyncValue<LoginEntity?>> {
  final Ref _ref;

  AuthNotifier(this._ref) : super(const AsyncValue.data(null));

  Future<void> login(LoginModel loginModel) async {
    final useCase = _ref.read(loginUseCaseProvider);
    state = const AsyncValue.loading();

    final result = await useCase.loginUser(loginModel: loginModel);

    result.fold(
          (failure) => state = AsyncValue.error(failure.message, StackTrace.current),
          (loginEntity) => state = AsyncValue.data(loginEntity),
    );
  }
}