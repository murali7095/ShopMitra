import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shop_mitra/feature/authentication/data/data_source/login_datasource.dart';
import 'package:shop_mitra/feature/authentication/data/repositoty/login_repo_impl.dart';
import 'package:shop_mitra/feature/authentication/domain/usecases/login_usecases.dart';

import '../../../../core/network/api_client.dart';
final httpClientProvider = Provider<http.Client>((ref) => http.Client());

final apiClientProvider = Provider<ApiClient>(
      (ref) => ApiClient(client: ref.read(httpClientProvider)),
);

final loginDSProvider = Provider<LoginDataSourceImpl>(
      (ref) => LoginDataSourceImpl(ref.read(apiClientProvider)),
);

final loginRepoProvider = Provider<LoginRepoImpl>(
      (ref) => LoginRepoImpl( ref.read(loginDSProvider)),
);

final loginUserProvider = Provider<LoginUseCase>(
      (ref) => LoginUseCase(ref.read(loginRepoProvider)),
);