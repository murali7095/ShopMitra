import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_mitra/core/exceptions/app_exceptions.dart';
import 'package:shop_mitra/feature/dashboard/data/model/product.dart';
import 'package:shop_mitra/feature/dashboard/domain/repo/dashboard_repo.dart';
import 'package:shop_mitra/feature/dashboard/domain/use_case/dashboard_use_case.dart';

class MockDashboardRepository extends Mock implements DashboardRepository {}

void main() {
  late DashboardUseCase dashboardUseCase;
  late MockDashboardRepository mockDashboardRepository;
  setUp(() {
    mockDashboardRepository = MockDashboardRepository();
    dashboardUseCase = DashboardUseCase(mockDashboardRepository);
  });

  var productsList = [
    Product(
      id: 1,
      title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
      price: 109.95,
      description:
      "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
      category: "men's clothing",
      image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png",
      productRating: ProductRating(rate: 3.9, count: 120),
    ),
    Product(
      id: 2,
      title: "Mens Casual Premium Slim Fit T-Shirts",
      price: 22.3,
      description:
      "Slim-fitting style, contrast raglan long sleeve, three-button henley placket, light weight & soft fabric for breathable and comfortable wearing. And Solid stitched shirts with round neck made for durability and a great fit for casual fashion wear and diehard baseball fans. The Henley style round neckline includes a three-button placket.",
      category: "men's clothing",
      image: "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_t.png",
      productRating: ProductRating(rate: 4.1, count: 259),
    ),
  ];


  test("should get list of products from repository '",  () async {
    when(()=>mockDashboardRepository.fetchAllProducts(allProductsUrl: "allProductsUrl")).thenAnswer((_) async=>Right(productsList));
    final result = await dashboardUseCase.fetchAllProducts(allProductsUrl: "allProductsUrl");
    expect(result.isRight(), true);
    expect(result, Right(productsList));
    verify(() => mockDashboardRepository.fetchAllProducts(allProductsUrl: "allProductsUrl")).called(1);

  });
  test("should return Failure when repo fails'",  () async {
    when(()=>mockDashboardRepository.fetchAllProducts(allProductsUrl: "allProductsUrl")).thenAnswer((_) async=>Left(AppException("Error")));
    final result = await dashboardUseCase.fetchAllProducts(allProductsUrl: "allProductsUrl");

    expect(result.isLeft(), true);
    expect(result.fold((l) => l.message, (_) => null), 'Error');
   // verify(() => mockDashboardRepository.fetchAllProducts(allProductsUrl: "allProductsUrl")).called(1);

  });
}
