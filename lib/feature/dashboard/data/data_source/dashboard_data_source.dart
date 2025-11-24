import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:shop_mitra/core/exceptions/app_exceptions.dart';
import 'package:shop_mitra/feature/dashboard/data/model/product.dart';

import '../../../../core/network/api_client.dart';

abstract class DashboardDataSource {
  Future<Either<AppException, List<Product>>> fetchAllProducts({
    required String allProductsUrl,
  });
}

class DashboardDataSourceImpl implements DashboardDataSource {
  //final String url;
  final ApiClient client;

  DashboardDataSourceImpl({required this.client});

  @override
  Future<Either<AppException, List<Product>>> fetchAllProducts({
    required String allProductsUrl,
  }) async {
    try {
      final http.Response response = await client.get(allProductsUrl);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        final List<Product> allProducts = listFromJson(jsonData);
        debugPrint("the success ${allProducts.length}");
        return Right(allProducts);

      } else {
        debugPrint("Failure ${response.statusCode}");

        return Left(AppException("Failure ${response.statusCode}"));
      }
    } catch (e) {
      debugPrint("Failure catch ${e.toString()}");

      return Left(AppException("Failure ${e.toString()}"));
    }
  }
}
