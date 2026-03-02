import 'package:book_store/src/core/services/api_service.dart';
import 'package:book_store/src/features/home/data/data_sources/home_local_data_source.dart';
import 'package:book_store/src/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:book_store/src/features/home/data/repos/home_repo_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider((ref) => Dio());

final homeRepoProvider = Provider((ref) {
  final dioInit= ref.watch(dioProvider);
  return HomeRepoImpl(
    homeRemoteDataSource: HomeRemoteDataSourceImpl(
      apiService: ApiService(dio: dioInit),
    ),
    homeLocalDataSource: HomeLocalDataSourceImpl(),
  );
});