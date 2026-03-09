import 'package:book_store/src/core/services/api_service.dart';
import 'package:book_store/src/features/home/data/data_sources/home_local_data_source.dart';
import 'package:book_store/src/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:book_store/src/features/home/data/repos/home_repo_impl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void setUpHomeService() {
  if (!getIt.isRegistered<ApiService>()) {
    getIt.registerSingleton<ApiService>(ApiService(dio: Dio()));
  }
  if (!getIt.isRegistered<HomeRepoImpl>()) {
    getIt.registerSingleton<HomeRepoImpl>(
      HomeRepoImpl(
        homeLocalDataSource: HomeLocalDataSourceImpl(),
        homeRemoteDataSource: HomeRemoteDataSourceImpl(
          apiService: getIt.get<ApiService>(),
        ),
      ),
    );
  }
}
