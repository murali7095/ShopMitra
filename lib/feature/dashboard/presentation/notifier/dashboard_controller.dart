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
    const allProductsUrl = "/products";

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

final adsProvider = Provider<List<String>>((ref) => ads,);
const ads=   [
    "https://images.unsplash.com/photo-1483985988355-763728e1935b",
    "https://images.unsplash.com/photo-1441986300917-64674bd600d8",
    "https://images.unsplash.com/photo-1608231387042-66d1773070a5",
    "https://images.unsplash.com/photo-1542291026-7eec264c27ff",
    "https://images.unsplash.com/photo-1503342217505-b0a15ec3261c",
    "https://images.unsplash.com/photo-1519741497674-611481863552"
  ];



