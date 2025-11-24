import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shop_mitra/feature/dashboard/data/data_source/dashboard_data_source.dart';
import 'package:shop_mitra/feature/dashboard/data/model/product.dart';
import 'package:shop_mitra/feature/dashboard/data/repository/products_repo_impl.dart';
import 'package:shop_mitra/feature/dashboard/domain/use_case/product_use_case.dart';
import 'package:http/http.dart' as http;
import '../../../../core/network/api_client.dart';

final productsNotifierProvider =
    StateNotifierProvider<ProductNotifier, AsyncValue<List<Product>>>((ref) {
      //final getUsers = ref.watch(getUsersProvider);

      return ProductNotifier(
        productsUseCase: ProductUseCase(
          ProductsRepoImpl(
            productsRepoImpl: DashboardDataSourceImpl(
              client: ApiClient(client: http.Client()),
            ),
          ),
        ),
        allProductsUrl: "https://fakestoreapi.com/products",
      );
    });

class ProductNotifier extends StateNotifier<AsyncValue<List<Product>>> {
  final ProductUseCase productsUseCase;
  final String allProductsUrl;

  ProductNotifier({required this.productsUseCase, required this.allProductsUrl})
    : super(const AsyncValue.loading()) {
    fetchAllProducts(allProductsUrl: allProductsUrl);
  }

  Future<void> fetchAllProducts({required String allProductsUrl}) async {
    state = const AsyncValue.loading();

    final either = await productsUseCase.fetchAllProducts(
      allProductsUrl: allProductsUrl,
    );

    either.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (allProducts) => state = AsyncValue.data(allProducts),
    );
  }
}
