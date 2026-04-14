import 'package:dartz/dartz.dart';
import 'package:shop_mitra/core/exceptions/app_exceptions.dart';
import 'package:shop_mitra/feature/profile/user/domain/entity/user.dart';
import 'package:shop_mitra/feature/profile/user/domain/repository/user_repository.dart';

class FetchUserDetails{
  final UserProfileRepository _repository;

  FetchUserDetails(this._repository);

 Future<Either<AppException,UserProfile>> fetchUserDetails({required String userDetailsUrl}){
   return _repository.fetchUserDetails(userDetailsUrl: userDetailsUrl);
 }
}