import 'package:dartz/dartz.dart';
import 'package:shop_mitra/feature/dashboard/domain/repo/product_repo.dart';

import '../../../../core/exceptions/app_exceptions.dart';
import '../../data/model/product.dart';

class ProductUseCase {
  final ProductRepository repository;

  ProductUseCase(this.repository);

  Future<Either<AppException, List<Product>>> fetchAllProducts({
    required String allProductsUrl,
  }) {
    return repository.fetchAllProducts(allProductsUrl: allProductsUrl);
  }
}
