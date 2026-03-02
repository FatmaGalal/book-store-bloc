import 'package:book_store/src/core/errors/failure.dart';
import 'package:book_store/src/features/home/domain/entities/book_entity.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<BookEntity>>> fetchBookList({required bool forceRefresh});
}
