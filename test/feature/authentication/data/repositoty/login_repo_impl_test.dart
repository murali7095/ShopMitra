import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_mitra/feature/authentication/data/data_source/login_datasource.dart';
import 'package:shop_mitra/feature/authentication/data/model/login_model.dart';
import 'package:shop_mitra/feature/authentication/data/model/auth_model.dart';
import 'package:shop_mitra/core/exceptions/app_exceptions.dart';
import 'package:shop_mitra/feature/authentication/data/repositoty/login_repo_impl.dart';

class MockLoginDataSource extends Mock implements LoginDataSourceImpl {}

void main() {
  late MockLoginDataSource mockDataSource;
  late LoginRepoImpl repository;

  setUp(() {
    mockDataSource = MockLoginDataSource();
    repository = LoginRepoImpl(mockDataSource);
  });

  final loginModel = LoginModel(
    email: 'test@gmail.com',
    password: 'Test@123',
    returnSecureToken: true,
  );

  const authModel = AuthModel(
    idToken: 'token',
    email: 'test@gmail.com',
    refreshToken: 'refresh',
    expiresIn: '3600',
    localId: 'local123',
    registered: true,
  );

  test('should return Right(AuthEntity) when data source succeeds', () async {
    // Arrange
    when(
      () => mockDataSource.userLogin(loginModel: loginModel),
    ).thenAnswer((_) async => authModel);

    // Act
    final result = await repository.userLogin(loginModel: loginModel);

    // Assert
    expect(result, Right(authModel));
    verify(() => mockDataSource.userLogin(loginModel: loginModel)).called(1);
    verifyNoMoreInteractions(mockDataSource);
  });

  test(
    'should return Left(AppException) when data source throws AppException',
    () async {
      // Arrange
      final exception = AppException('Login failed');

      when(
        () => mockDataSource.userLogin(loginModel: loginModel),
      ).thenThrow(exception);

      // Act
      final result = await repository.userLogin(loginModel: loginModel);

      // Assert
      expect(result.isLeft(), true);

      result.fold(
        (error) => expect(error, isA<AppException>()),
        (_) => fail('Expected failure'),
      );
    },
  );

  test(
    'should return Left(AppException) when data source throws unknown error',
    () async {
      // Arrange
      when(
        () => mockDataSource.userLogin(loginModel: loginModel),
      ).thenThrow(Exception('Unexpected'));

      // Act
      final result = await repository.userLogin(loginModel: loginModel);

      // Assert
      expect(result.isLeft(), true);
    },
  );
}
