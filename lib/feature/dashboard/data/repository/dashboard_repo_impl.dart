import 'package:dartz/dartz.dart';
import 'package:shop_mitra/core/exceptions/app_exceptions.dart';
import 'package:shop_mitra/feature/dashboard/data/data_source/dashboard_data_source.dart';
import 'package:shop_mitra/feature/dashboard/data/model/product.dart';
import 'package:shop_mitra/feature/dashboard/domain/repo/dashboard_repo.dart';

class DashboardRepoImpl implements DashboardRepository {
  final DashboardDataSourceImpl productsRepoImpl;

  DashboardRepoImpl({required this.productsRepoImpl});

  @override
  Future<Either<AppException, List<ProductModel>>> fetchAllProducts({
    required String allProductsUrl,
  }) async {
    try {
      final response = await productsRepoImpl.fetchAllProducts(
        allProductsUrl: allProductsUrl,
      );
      return Right(response);
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }
}
