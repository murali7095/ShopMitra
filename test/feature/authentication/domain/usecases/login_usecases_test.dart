import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_mitra/core/exceptions/app_exceptions.dart';
import 'package:shop_mitra/feature/authentication/data/model/login_model.dart';
import 'package:shop_mitra/feature/authentication/domain/entitites/auth_entity.dart';
import 'package:shop_mitra/feature/authentication/domain/repositories/login_repository.dart';
import 'package:shop_mitra/feature/authentication/domain/usecases/login_usecases.dart';

class MockLoginRepository extends Mock implements LoginRepository{}
void main() {
  late MockLoginRepository repository;
  late LoginUseCase useCase;

  setUp(() {
    repository = MockLoginRepository();
    useCase = LoginUseCase(repository);
  });

  final loginModel = LoginModel(
    email: "test@gmail.com",
    password: "Test@123",
    returnSecureToken: true,
  );

  const authEntity = AuthEntity(
    idToken: "idToken",
    email: "test@gmail.com",
    refreshToken: "jhdvfsdhfjdfj",
    expiresIn: "232",
    localId: "ssdvfvds",
    registered: true,
  );

  test("should return AuthEntity when api succeeds", () async {
    // Arrange
    when(() => repository.userLogin(loginModel: loginModel))
        .thenAnswer((_) async => Right(authEntity));

    // Act
    final result = await useCase.loginUser(loginModel: loginModel);

    // Assert
    expect(result, Right(authEntity));
    verify(() => repository.userLogin(loginModel: loginModel)).called(1);
    verifyNoMoreInteractions(repository);
  });

  test("should return AppException when api fails", () async {
    // Arrange
    final appException = AppException("Failed to login");

    when(() => repository.userLogin(loginModel: loginModel))
        .thenAnswer((_) async => Left(appException));

    // Act
    final result = await useCase.loginUser(loginModel: loginModel);

    // Assert
    expect(result, Left(appException));
    verify(() => repository.userLogin(loginModel: loginModel)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
