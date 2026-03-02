import 'package:book_store/src/core/errors/failure.dart';
import 'package:book_store/src/features/home/data/data_sources/home_local_data_source.dart';
import 'package:book_store/src/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:book_store/src/features/home/domain/entities/book_entity.dart';
import 'package:book_store/src/features/home/domain/repos/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeLocalDataSource homeLocalDataSource;
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepoImpl({
    required this.homeLocalDataSource,
    required this.homeRemoteDataSource,
  });
  @override
  Future<Either<Failure, List<BookEntity>>> fetchBookList({
    bool forceRefresh = false,
  }) async {
    try {
      if (!forceRefresh) {
        final cachedBooks = homeLocalDataSource.fetchBookList();
        if (cachedBooks.isNotEmpty) return right(cachedBooks);
      }

      List<BookEntity> books = await homeRemoteDataSource.fetchBookList();
      return right(books);
    } catch (e) {
      final cachedBooks = homeLocalDataSource.fetchBookList();

      if (cachedBooks.isNotEmpty) {
        return right(cachedBooks);
      } else if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }

      return Left(ServerFailure(e.toString()));
    }
  }
}
