import 'package:book_store/src/core/errors/failure.dart';
import 'package:book_store/src/core/helpers/use_case.dart';
import 'package:book_store/src/features/home/domain/entities/book_entity.dart';
import 'package:book_store/src/features/home/domain/repos/home_repo.dart';
import 'package:dartz/dartz.dart';

class FetchBookListUseCase extends UseCase<List<BookEntity>, NoParam> {
  final HomeRepo homeRepo;

  FetchBookListUseCase({required this.homeRepo});

  @override
  Future<Either<Failure, List<BookEntity>>> call([NoParam? param]) {
    return homeRepo.fetchBookList(forceRefresh: false);
  }
}
