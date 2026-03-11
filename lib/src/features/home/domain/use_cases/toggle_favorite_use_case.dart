import 'package:book_store/src/core/errors/failure.dart';
import 'package:book_store/src/core/helpers/use_case.dart';
import 'package:book_store/src/features/home/domain/entities/book_entity.dart';
import 'package:book_store/src/features/home/domain/repos/home_repo.dart';
import 'package:dartz/dartz.dart';

class ToggleFavoriteUseCase extends UseCase<List<BookEntity>, BookEntity> {
  final HomeRepo homeRepo;

  ToggleFavoriteUseCase({required this.homeRepo});

  @override
  Future<Either<Failure, List<BookEntity>>> call([BookEntity? param]) {
    if (param == null) {
      throw ArgumentError('BookEntity param is required');
    }

    return homeRepo.toggleFavorite(param);
  }
}
