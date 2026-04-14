import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:shop_mitra/core/exceptions/app_exceptions.dart';
import 'package:shop_mitra/feature/dashboard/data/model/product.dart';
import 'package:shop_mitra/feature/dashboard/presentation/notifier/dashboard_controller.dart';

import '../../../../core/network/api_client.dart';

abstract class DashboardDataSource {
  Future<List<ProductModel>> fetchAllProducts({required String allProductsUrl});
  Future<List<String>> fetchAppAds({required String adsUrl});
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
      debugPrint("the res;${response.body}");
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        return productsList(jsonData);
      } else {
        throw AppException(
          "Server error: ${response.statusCode}",
        );
      }
    } on SocketException {
      throw AppException("No Internet Connection");
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException("Unexpected error: $e");
    }
  }

  @override
  Future<List<String>> fetchAppAds({required String adsUrl}) async {
    try {
      final response = await client.get(otherUrl: adsUrl,'');

      final jsonData = json.decode(response.body);
      return List<String>.from(jsonData);

    } on NotFoundException {
      throw AppException("Ads not found");
    } on NetworkException {
      throw AppException("No internet connection");
    } on AppException {
      rethrow; // other app exceptions
    } catch (e) {
      throw AppException("Unexpected error");
    }
  }


}
