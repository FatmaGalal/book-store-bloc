import 'package:book_store/src/core/services/api_service.dart';
import 'package:book_store/src/features/authentication/data/auth_service.dart';
import 'package:book_store/src/features/home/data/data_sources/home_local_data_source.dart';
import 'package:book_store/src/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:book_store/src/features/home/data/repos/home_repo_impl.dart';
import 'package:book_store/src/features/home/domain/use_cases/fetch_book_list_use_case.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setUpDependencies() {
  setUpAuthService();
  setUpHomeService();
}

void setUpAuthService() {
  if (!getIt.isRegistered<FirebaseAuth>()) {
    getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  }

  if (!getIt.isRegistered<AuthService>()) {
    getIt.registerLazySingleton<AuthService>(
      () => AuthService(auth: getIt.get<FirebaseAuth>()),
    );
  }
}

void setUpHomeService() {
  if (!getIt.isRegistered<Dio>()) {
    getIt.registerLazySingleton(() => Dio());
  }

  if (!getIt.isRegistered<ApiService>()) {
    getIt.registerLazySingleton<ApiService>(
      () => ApiService(dio: getIt.get<Dio>()),
    );
  }

  if (!getIt.isRegistered<HomeRepoImpl>()) {
    getIt.registerLazySingleton<HomeRepoImpl>(
      () => HomeRepoImpl(
        homeLocalDataSource: HomeLocalDataSourceImpl(),
        homeRemoteDataSource: HomeRemoteDataSourceImpl(
          apiService: getIt.get<ApiService>(),
        ),
      ),
    );
  }

  if (!getIt.isRegistered<FetchBookListUseCase>()) {
    getIt.registerLazySingleton<FetchBookListUseCase>(
      () => FetchBookListUseCase(homeRepo: getIt.get<HomeRepoImpl>()),
    );
  }
}
