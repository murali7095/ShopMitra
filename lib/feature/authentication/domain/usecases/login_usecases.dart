import 'package:dartz/dartz.dart';
import 'package:shop_mitra/core/exceptions/app_exceptions.dart';
import 'package:shop_mitra/feature/authentication/data/model/login_model.dart';

import '../entitites/auth_entity.dart';
import '../repositories/login_repository.dart';

class LoginUseCase{
  final LoginRepository _loginRepository;
  LoginUseCase(this._loginRepository);
  Future<Either<AppException,AuthEntity>> loginUser({required LoginModel loginModel}){
    return _loginRepository.userLogin(loginModel: loginModel);
  }
}