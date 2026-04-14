import 'package:dartz/dartz.dart';
import 'package:shop_mitra/core/exceptions/app_exceptions.dart';
import 'package:shop_mitra/feature/profile/user/domain/entity/user.dart';

abstract class UserProfileRepository{
  Future<Either<AppException,UserProfile>> fetchUserDetails({required String userDetailsUrl});
}