// import 'dart:convert';
//
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:shop_mitra/core/exceptions/app_exceptions.dart';
// import 'package:shop_mitra/core/network/api_client.dart';
// import 'package:shop_mitra/feature/dashboard_test/data/data_source/dashboard_data_source.dart';
// import 'package:shop_mitra/feature/dashboard_test/data/model/product.dart';
// import 'package:http/http.dart' as http;
// class MockApiClient extends Mock implements ApiClient {}
// void main() {
//   late MockApiClient mockClient;
//   late DashboardDataSourceImpl dataSource;
//
//   const fetchAllProductsApi = "https://example.com/products";
//
//   setUp(() {
//     mockClient = MockApiClient();
//     dataSource = DashboardDataSourceImpl(client: mockClient);
//   });
//
//   group("DashboardDataSourceImpl.fetchAllProducts", () {
//     test("returns Right<List<Product>> when response is 200", () async {
//       // Arrange
//       final fakeJson = [
//         {"id":2,"title":"Mens Casual Premium Slim Fit T-Shirts ","price":22.3,"description":"Slim-fitting style, contrast raglan long sleeve, three-button henley placket, light weight & soft fabric for breathable and comfortable wearing. And Solid stitched shirts with round neck made for durability and a great fit for casual fashion wear and diehard baseball fans. The Henley style round neckline includes a three-button placket.","category":"men's clothing","image":"https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_t.png","rating":{"rate":4.1,"count":259}},
//         {"id":1,"title":"Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops","price":109.95,"description":"Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday","category":"men's clothing","image":"https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png","rating":{"rate":3.9,"count":120}}
//       ];
//
//       when(() => mockClient.get(fetchAllProductsApi)).thenAnswer(
//             (_) async => http.Response(json.encode(fakeJson), 200),
//       );
//
//       // Act
//       final result = await dataSource.fetchAllProducts(allProductsUrl: fetchAllProductsApi);
//
//       // Assert
//       result.fold(
//             (failure) => fail("Should not return Left: $failure"),
//             (products) {
//           expect(products, isA<List<Product>>());
//           expect(products.length, 2);
//           expect(products[0].id, 2);
//           expect(products[0].title, "Mens Casual Premium Slim Fit T-Shirts ");
//         },
//       );
//
//       verify(() => mockClient.get(fetchAllProductsApi)).called(1);
//     });
//
//     test("returns Left(AppException) when response is NOT 200", () async {
//       // Arrange
//       when(() => mockClient.get(fetchAllProductsApi)).thenAnswer(
//             (_) async => http.Response("Something went wrong", 500),
//       );
//
//       // Act
//       final result = await dataSource.fetchAllProducts(allProductsUrl: fetchAllProductsApi);
//
//       // Assert
//       result.fold(
//             (failure) {
//           expect(failure, isA<AppException>());
//           expect(failure.message, contains("Failure 500"));
//         },
//             (_) => fail("Should not return Right on non-200"),
//       );
//
//       verify(() => mockClient.get(fetchAllProductsApi)).called(1);
//     });
//
//     test("returns Left(AppException) when an exception is thrown", () async {
//       // Arrange
//       when(() => mockClient.get(fetchAllProductsApi)).thenThrow(
//         Exception("Network Error"),
//       );
//
//       // Act
//       final result = await dataSource.fetchAllProducts(allProductsUrl: fetchAllProductsApi);
//
//       // Assert
//       result.fold(
//             (failure) {
//           expect(failure, isA<AppException>());
//           expect(failure.message, contains("Failure Exception"));
//         },
//             (_) => fail("Should not return Right when exception occurs"),
//       );
//
//       verify(() => mockClient.get(fetchAllProductsApi)).called(1);
//     });
//   });
// }