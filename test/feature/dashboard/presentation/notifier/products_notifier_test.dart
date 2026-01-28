import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_mitra/core/exceptions/app_exceptions.dart';
import 'package:shop_mitra/feature/dashboard/domain/entity/product.dart';
import 'package:shop_mitra/feature/dashboard/domain/use_case/dashboard_use_case.dart';
import 'package:shop_mitra/feature/dashboard/presentation/notifier/products_notifier.dart';

class MockFetchProducts extends Mock implements FetchProducts {}

void main() {
  late MockFetchProducts mockFetchProducts;
  late ProviderContainer container;

  const testUrl = "https://fakestoreapi.com/products";

  final testProducts = [
    Product(
      id: 2,
      title: "Mens Casual Premium Slim Fit T-Shirts",
      price: 22.3,
      description: "Slim-fitting style...",
      category: "men's clothing",
      image:
      "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_t.png",
      productRating: ProductRating(rate: 4.1, count: 259),
    ),
  ];

  setUp(() {
    mockFetchProducts = MockFetchProducts();

    // 1️⃣ Stub the fetchAllProducts method BEFORE creating the notifier
    when(() => mockFetchProducts.fetchAllProducts(allProductsUrl: testUrl))
        .thenAnswer((_) async => Right(testProducts));

    container = ProviderContainer(overrides: [
      productNotifierProvider.overrideWith((ref) {
        return ProductNotifier(
          productsUseCase: mockFetchProducts,
          allProductsUrl: testUrl,
        );
      })
    ]);
  });

  tearDown(() {
    container.dispose();
  });

  test('initial state is loading', () {
    final state = container.read(productNotifierProvider);
    expect(state.isLoading, true);
  });

  test('fetchAllProducts success updates state with data', () async {
    final notifier = container.read(productNotifierProvider.notifier);

    // 2️⃣ Wait for the constructor async fetch to complete
    await Future.delayed(Duration.zero);

    final state = container.read(productNotifierProvider);
    expect(state.isLoading, false);
    expect(state.value, testProducts);
  });

  test('fetchAllProducts failure updates state with error', () async {
    // arrange: override stub to return failure
    when(() => mockFetchProducts.fetchAllProducts(allProductsUrl: testUrl))
        .thenAnswer((_) async => Left(AppException("Network error")));

    // Re-create container so the notifier calls the stubbed failure
    container = ProviderContainer(overrides: [
      productNotifierProvider.overrideWith((ref) {
        return ProductNotifier(
          productsUseCase: mockFetchProducts,
          allProductsUrl: testUrl,
        );
      })
    ]);

    final notifier = container.read(productNotifierProvider.notifier);

    // Wait for async constructor call
    await Future.delayed(Duration.zero);

    final state = container.read(productNotifierProvider);
    expect(state.hasError, true);
    expect(state.error.toString(), contains("Network error"));
  });
}
