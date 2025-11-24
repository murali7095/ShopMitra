import 'package:dartz/dartz.dart';
import 'package:shop_mitra/core/exceptions/app_exceptions.dart';
import 'package:shop_mitra/feature/dashboard/data/data_source/dashboard_data_source.dart';
import 'package:shop_mitra/feature/dashboard/data/model/product.dart';
import 'package:shop_mitra/feature/dashboard/domain/repo/product_repo.dart';

class ProductsRepoImpl implements ProductRepository {
  final DashboardDataSourceImpl productsRepoImpl;

  ProductsRepoImpl({required this.productsRepoImpl});

  @override
  Future<Either<AppException, List<Product>>> fetchAllProducts({
    required String allProductsUrl,
  }) async {
    try {
      final response = await productsRepoImpl.fetchAllProducts(
        allProductsUrl: allProductsUrl,
      );
      return response.fold(
        (l) {
          return Left(l);
        },
        (r) {
          return Right(r);
        },
      );
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }
}
