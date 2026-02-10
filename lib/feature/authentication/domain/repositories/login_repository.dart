// coverage:ignore-file
import 'package:dartz/dartz.dart';
import 'package:shop_mitra/core/exceptions/app_exceptions.dart';
import 'package:shop_mitra/feature/authentication/data/model/login_model.dart';

import '../entitites/auth_entity.dart';

abstract class LoginRepository{
  Future<Either<AppException,AuthEntity>> userLogin({required LoginModel loginModel});
}