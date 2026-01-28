import 'package:dartz/dartz.dart';
import 'package:shop_mitra/feature/dashboard/domain/repo/dashboard_repo.dart';

import '../../../../core/exceptions/app_exceptions.dart';
import '../entity/product.dart';

class FetchProducts {
  final DashboardRepository repository;

  FetchProducts(this.repository);

  Future<Either<AppException, List<Product>>> fetchAllProducts({
    required String allProductsUrl,
  }) {
    return repository.fetchAllProducts(allProductsUrl: allProductsUrl);
  }
}
