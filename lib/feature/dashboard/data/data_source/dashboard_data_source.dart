import 'dart:convert';

import 'package:shop_mitra/core/exceptions/app_exceptions.dart';
import 'package:shop_mitra/feature/dashboard/data/model/product.dart';

import '../../../../core/network/api_client.dart';

abstract class DashboardDataSource {
  Future<List<ProductModel>> fetchAllProducts({required String allProductsUrl});
}

class DashboardDataSourceImpl implements DashboardDataSource {
  final ApiClient client;

  DashboardDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> fetchAllProducts({
    required String allProductsUrl,
  }) async {
    try {
      final response = await client.get(allProductsUrl);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return productsList(jsonData);
      } else {
        throw AppException(
          "Server error: ${response.statusCode}",
        );
      }
    } on AppException {
      rethrow; // keep original exception
    } catch (e) {
      throw AppException("Unexpected error: $e");
    }
  }

}
