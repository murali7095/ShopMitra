import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/app_exceptions.dart';
import '../entity/product.dart';

abstract class DashboardRepository {
  Future<Either<AppException, List<Product>>> fetchAllProducts({
    required String allProductsUrl,
  });
}
