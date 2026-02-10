import 'package:dartz/dartz.dart';
import 'package:shop_mitra/core/exceptions/app_exceptions.dart';
import 'package:shop_mitra/feature/authentication/data/data_source/login_datasource.dart';
import 'package:shop_mitra/feature/authentication/data/model/login_model.dart';
import 'package:shop_mitra/feature/authentication/domain/entitites/auth_entity.dart';
 import 'package:shop_mitra/feature/authentication/domain/repositories/login_repository.dart';

class LoginRepoImpl implements LoginRepository{
  final LoginDataSourceImpl dataSourceImpl;

  LoginRepoImpl(this.dataSourceImpl);
  @override
  Future<Either<AppException, AuthEntity>> userLogin({required LoginModel loginModel}) async{
     try{
       final result = await dataSourceImpl.userLogin(loginModel: loginModel);
       return Right(result);
     }catch(e){
       return Left(AppException(e.toString()));
     }
  }


}