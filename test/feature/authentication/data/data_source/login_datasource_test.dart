import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_mitra/core/exceptions/app_exceptions.dart';
import 'package:shop_mitra/core/network/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:shop_mitra/feature/authentication/data/data_source/login_datasource.dart';
import 'package:shop_mitra/feature/authentication/data/model/auth_model.dart';
import 'package:shop_mitra/feature/authentication/data/model/login_model.dart';
class MockApiClient extends Mock implements ApiClient{}
void main() {
  late MockApiClient mockApiClient;
  late LoginDataSourceImpl dataSource;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = LoginDataSourceImpl(mockApiClient);
  });

  final loginModel = LoginModel(
    email: 'test@gmail.com',
    password: 'Test@123',
    returnSecureToken: true,
  );

  final successJson = {
    "idToken": "token",
    "email": "test@gmail.com",
    "refreshToken": "refresh",
    "expiresIn": "3600",
    "localId": "local123",
    "registered": true,
  };

  test('should return AuthModel when API call succeeds', () async {
    // Arrange
    when(() => mockApiClient.post(any(), any())).thenAnswer(
          (_) async => http.Response(jsonEncode(successJson), 200),
    );

    // Act
    final result = await dataSource.userLogin(loginModel: loginModel);

    // Assert
    expect(result, isA<AuthModel>());
    expect(result.email, 'test@gmail.com');
    expect(result.registered, true);

    verify(() => mockApiClient.post(any(), any())).called(1);
    verifyNoMoreInteractions(mockApiClient);
  });

  test('should throw AppException when API returns non-200', () async {
    // Arrange
    when(() => mockApiClient.post(any(), any())).thenAnswer(
          (_) async => http.Response('Error', 500),
    );

    // Act
    final call = dataSource.userLogin(loginModel: loginModel);

    // Assert
    expect(call, throwsA(isA<AppException>()));
  });

  test('should rethrow AppException from ApiClient', () async {
    // Arrange
    when(() => mockApiClient.post(any(),  {}))
        .thenThrow(AppException('API failure'));

    // Act
    final call = dataSource.userLogin(loginModel: loginModel);

    // Assert
    expect(call, throwsA(isA<AppException>()));
  });
}
