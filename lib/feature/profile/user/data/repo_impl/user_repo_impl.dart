import 'package:dartz/dartz.dart';
import 'package:shop_mitra/core/exceptions/app_exceptions.dart';
import 'package:shop_mitra/feature/profile/user/data/data_source/user_data_source.dart';
import 'package:shop_mitra/feature/profile/user/domain/entity/user.dart';
import 'package:shop_mitra/feature/profile/user/domain/repository/user_repository.dart';

class UserProfileRepoImpl implements UserProfileRepository{
  final UserDataSource _userDataSource;

  UserProfileRepoImpl(this._userDataSource);
  @override
  Future<Either<AppException,UserProfile>> fetchUserDetails({required String userDetailsUrl}) async{
    try{
      final userProfile = await _userDataSource.fetchUserDetails(userDetailsUrl: userDetailsUrl);
      return Right(userProfile);
    }catch(e){
      return Left(AppException(e.toString()));
    }
  }

}