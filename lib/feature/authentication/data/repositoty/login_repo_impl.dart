import 'package:dartz/dartz.dart';
import 'package:shop_mitra/core/exceptions/app_exceptions.dart';
import 'package:shop_mitra/feature/authentication/data/model/login_model.dart';
import 'package:shop_mitra/feature/authentication/domain/entitites/login_entity.dart';
import 'package:shop_mitra/feature/authentication/domain/repositories/login_repository.dart';

class LoginRepoImpl implements LoginRepository{
  @override
  Future<Either<AppException, LoginEntity>> userLogin({required LoginModel loginModel}) {
    // TODO: implement userLogin
    throw UnimplementedError();
  }


}