import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../../core/network/api_client.dart';
import '../../data/data_source/dashboard_data_source.dart';
import '../../data/repository/dashboard_repo_impl.dart';
import '../../domain/use_case/dashboard_use_case.dart';
final httpClientProvider = Provider<http.Client>((ref) => http.Client());

final apiClientProvider = Provider<ApiClient>(
      (ref) => ApiClient(client: ref.read(httpClientProvider)),
);

final dashboardDSProvider = Provider<DashboardDataSourceImpl>(
      (ref) => DashboardDataSourceImpl(client: ref.read(apiClientProvider)),
);

final dashboardRepoProvider = Provider<DashboardRepoImpl>(
      (ref) => DashboardRepoImpl(productsRepoImpl: ref.read(dashboardDSProvider)),
);

final fetchProductsProvider = Provider<FetchProducts>(
      (ref) => FetchProducts(ref.read(dashboardRepoProvider)),
);