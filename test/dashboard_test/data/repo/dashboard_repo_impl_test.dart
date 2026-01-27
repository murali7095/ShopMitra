// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:shop_mitra/core/exceptions/app_exceptions.dart';
// import 'package:shop_mitra/feature/dashboard_test/data/data_source/dashboard_data_source.dart';
// import 'package:shop_mitra/feature/dashboard_test/data/model/product.dart';
// import 'package:shop_mitra/feature/dashboard_test/data/repository/dashboard_repo_impl.dart';
//
// class MockDashboardDataSourceImpl extends Mock
//     implements DashboardDataSourceImpl {}
//
// const fetchAllProductsApi = "https://example.com/products";
//
// void main() {
//   late DashboardRepoImpl repo;
//   late MockDashboardDataSourceImpl mockDataSource;
//
//   setUp(() {
//     mockDataSource = MockDashboardDataSourceImpl();
//     repo = DashboardRepoImpl(productsRepoImpl: mockDataSource);
//   });
//
//   // ---- SAMPLE DATA ----
//   var productsList = [
//     Product(
//       id: 1,
//       title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
//       price: 109.95,
//       description:
//       "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
//       category: "men's clothing",
//       image:
//       "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png",
//       productRating: ProductRating(rate: 3.9, count: 120),
//     ),
//     Product(
//       id: 2,
//       title: "Mens Casual Premium Slim Fit T-Shirts",
//       price: 22.3,
//       description:
//       "Slim-fitting style, contrast raglan long sleeve, ...",
//       category: "men's clothing",
//       image:
//       "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_t.png",
//       productRating: ProductRating(rate: 4.1, count: 259),
//     ),
//   ];
//
//   // -------------------- TEST ----------------------------
//   test("Repository returns product list when datasource succeeds", () async {
//     // Mock datasource success
//     when(() => mockDataSource.fetchAllProducts(
//         allProductsUrl: fetchAllProductsApi))
//         .thenAnswer((_) async => Right(productsList));
//
//     // Call repository
//     final result =
//     await repo.fetchAllProducts(allProductsUrl: fetchAllProductsApi);
//
//     // Validate result
//     result.fold(
//           (failure) => fail("Should not return Left: $failure"),
//           (products) {
//         expect(products, isA<List<Product>>());
//         expect(products.length, 2);
//         expect(products[0].id, 1);
//         expect(products[1].id, 2);
//       },
//     );
//
//     // Verify datasource was called
//     verify(() => mockDataSource.fetchAllProducts(
//         allProductsUrl: fetchAllProductsApi)).called(1);
//   });
//
//   // ----------- FAILURE TEST ------------
//   test("Repository returns Left when datasource fails", () async {
//     final exception = AppException("Something went wrong");
//
//     when(() => mockDataSource.fetchAllProducts(
//         allProductsUrl: fetchAllProductsApi))
//         .thenAnswer((_) async => Left(exception));
//
//     final result =
//     await repo.fetchAllProducts(allProductsUrl: fetchAllProductsApi);
//
//     expect(result.isLeft(), true);
//   });
//   test("returns Left(AppException) when an exception is thrown", () async {
//     // Arrange
//     when(() => mockDataSource.fetchAllProducts(allProductsUrl: fetchAllProductsApi)).thenThrow(
//       Exception("Network Error"),
//     );
//
//     // Act
//     final result = await repo.fetchAllProducts(allProductsUrl: fetchAllProductsApi);
//
//     // Assert
//     result.fold(
//           (failure) {
//         expect(failure, isA<AppException>());
//         expect(failure.message, contains("Network Error"));
//       },
//           (_) => fail("Should not return Right when exception occurs"),
//     );
//
//     //verify(() => mockClient.get(fetchAllProductsApi)).called(1);
//   });
//
// }
