import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shop_mitra/core/network/api_client.dart';
import 'package:shop_mitra/feature/dashboard/data/data_source/dashboard_data_source.dart';
import 'package:shop_mitra/feature/dashboard/data/repository/dashboard_repo_impl.dart';
import 'package:shop_mitra/feature/dashboard/domain/entity/product.dart';
import 'package:shop_mitra/feature/dashboard/domain/use_case/dashboard_use_case.dart';

import 'dashboard_dependencies.dart';




/// --------------------
/// AsyncNotifier
/// --------------------

final productsNotifierProvider =
AsyncNotifierProvider<ProductsNotifier, List<Product>>(
  ProductsNotifier.new,
);

class ProductsNotifier extends AsyncNotifier<List<Product>> {
  @override
  Future<List<Product>> build() async {
    // You can make the URL configurable if needed
    const allProductsUrl = "https://fakestoreapi.com/products";

    // Read your use case from DI
    final fetchProducts = ref.read(fetchProductsProvider);

    final result = await fetchProducts.fetchAllProducts(allProductsUrl: allProductsUrl);

    // Handle success or error
    return result.fold(
          (failure) {
        debugPrint("Fetch products error: $failure");
        throw failure; // AsyncNotifier will automatically set AsyncValue.error
      },
          (products) => products,
    );
  }
}

