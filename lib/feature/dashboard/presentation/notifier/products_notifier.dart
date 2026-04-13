import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:http/http.dart' as http;
import 'package:shop_mitra/feature/dashboard/data/data_source/dashboard_data_source.dart';
import 'package:shop_mitra/feature/dashboard/data/model/product.dart';
import 'package:shop_mitra/feature/dashboard/data/repository/dashboard_repo_impl.dart';
import 'package:shop_mitra/feature/dashboard/domain/use_case/dashboard_use_case.dart';

import '../../../../core/network/api_client.dart';
import '../../domain/entity/categoty.dart';
import '../../domain/entity/product.dart';

final productNotifierProvider =
    StateNotifierProvider<ProductNotifier, AsyncValue<List<Product>>>((ref) {
      //final getUsers = ref.watch(getUsersProvider);

      return ProductNotifier(
        productsUseCase: FetchProducts(
          DashboardRepoImpl(
            productsRepoImpl: DashboardDataSourceImpl(
              client: ApiClient(client: http.Client()),
            ),
          ),
        ),
        allProductsUrl: "https://fakestoreapi.com/products",
      );
    });


final categoryList = [
  Category(name: "All", icon: "assets/image/categories/grid.png"),
  Category(name: "Top", icon: "assets/image/categories/casual-t-shirt-.png"),
  Category(name: "Bottoms", icon: "assets/image/categories/pants.png"),
  Category(name: "Dresses", icon: "assets/image/categories/dress.png"),
  Category(name: "Jewelry", icon: "assets/image/categories/jewelry.png"),
];


class ProductNotifier extends StateNotifier<AsyncValue<List<Product>>> {
  final FetchProducts productsUseCase;
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
