import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_mitra/core/exceptions/app_exceptions.dart';
import 'package:shop_mitra/core/network/api_client.dart';
import 'package:shop_mitra/feature/dashboard/data/data_source/dashboard_data_source.dart';
import 'package:shop_mitra/feature/dashboard/data/repository/dashboard_repo_impl.dart';
import 'package:shop_mitra/feature/dashboard/domain/entity/product.dart';
import 'package:shop_mitra/feature/dashboard/domain/use_case/dashboard_use_case.dart';
import 'package:http/http.dart' as http;
import 'package:shop_mitra/feature/dashboard/presentation/notifier/dashboard_controller.dart';
import 'package:shop_mitra/feature/dashboard/presentation/notifier/dashboard_dependencies.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockApiClient extends Mock implements ApiClient {}

class MockDashboardDS extends Mock implements DashboardDataSourceImpl {}

class MockDashboardRepo extends Mock implements DashboardRepoImpl {}

class MockFetchProducts extends Mock implements FetchProducts {}

void main() {
  group('Dependency Injection Providers', () {
    test('httpClientProvider returns an http.Client', () {
      final container = ProviderContainer();
      final client = container.read(httpClientProvider);
      expect(client, isA<http.Client>());
    });

    test('apiClientProvider returns ApiClient using httpClient', () {
      final container = ProviderContainer();
      final apiClient = container.read(apiClientProvider);
      expect(apiClient, isA<ApiClient>());
      expect(apiClient.httpClient, container.read(httpClientProvider));
    });

    test(
      'dashboardDSProvider returns DashboardDataSourceImpl using ApiClient',
      () {
        final container = ProviderContainer();
        final ds = container.read(dashboardDSProvider);
        expect(ds, isA<DashboardDataSourceImpl>());
        expect(ds.client, container.read(apiClientProvider));
      },
    );

    test(
      'dashboardRepoProvider returns DashboardRepoImpl using DashboardDataSourceImpl',
      () {
        final container = ProviderContainer();
        final repo = container.read(dashboardRepoProvider);
        expect(repo, isA<DashboardRepoImpl>());
        expect(repo.productsRepoImpl, container.read(dashboardDSProvider));
      },
    );

    test(
      'fetchProductsProvider returns FetchProducts using DashboardRepoImpl',
      () {
        final container = ProviderContainer();
        final useCase = container.read(fetchProductsProvider);
        expect(useCase, isA<FetchProducts>());
        expect(useCase.repository, container.read(dashboardRepoProvider));
      },
    );
  });
  group('ProductsNotifier AsyncNotifier', () {
    late MockFetchProducts mockFetchProducts;
    late ProviderContainer container;

    setUp(() {
      mockFetchProducts = MockFetchProducts();
      container = ProviderContainer(
        overrides: [fetchProductsProvider.overrideWithValue(mockFetchProducts)],
      );
    });

    test('emits products on successful fetch', () async {
      final productsList = [
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

      // Mock the fetchAllProducts to return success
      when(
        () => mockFetchProducts.fetchAllProducts(
          allProductsUrl: any(named: 'allProductsUrl'),
        ),
      ).thenAnswer((_) async => Right(productsList));

      final notifier = container.read(productsNotifierProvider.notifier);

      final result = await notifier.build();

      expect(result, productsList);
    });

    test('throws error on failed fetch', () async {
      final failure = AppException('Network Error');

      // Mock the fetchAllProducts to return failure
      when(
        () => mockFetchProducts.fetchAllProducts(
          allProductsUrl: any(named: 'allProductsUrl'),
        ),
      ).thenAnswer((_) async => Left(failure));

      final notifier = container.read(productsNotifierProvider.notifier);

      expect(() async => await notifier.build(), throwsA(failure));
    });
  });
}

/*void main() {
  late MockFetchProducts mockFetchProducts;
  late ProviderContainer container;

  setUpAll(() {
    registerFallbackValue(''); // 🔥 REQUIRED
  });

  setUp(() {
    mockFetchProducts = MockFetchProducts();
    container = ProviderContainer(
      overrides: [
        fetchProductsProvider.overrideWithValue(mockFetchProducts),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  final products = [
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


  test("emits List<Product> when fetchProducts succeeds", () async {
    when(() => mockFetchProducts.fetchAllProducts(
      allProductsUrl: any(named: 'allProductsUrl'),
    )).thenAnswer(
          (_) async => Right(products),
    );

    final result =
    await container.read(productsNotifierProvider.future);

    expect(result, products);
  });

  test("throws error when fetchProducts fails", () async {
    final exception = AppException("failed to load products");

    when(() => mockFetchProducts.fetchAllProducts(
      allProductsUrl: any(named: 'allProductsUrl'),
    )).thenAnswer(
          (_) async => Left(exception),
    );
    final result = container.read(productsNotifierProvider.future);
      expectLater(
     result ,
      throwsA(isA<AppException>()),
    );
  });
}*/
