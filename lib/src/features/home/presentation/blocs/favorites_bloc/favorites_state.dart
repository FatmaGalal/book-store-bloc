part of 'favorites_bloc.dart';

@immutable
sealed class FavoritesState {}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesBooksLoaded extends FavoritesState {
  final List<BookEntity> favorites;

  FavoritesBooksLoaded(this.favorites);

  bool isFavorite(String bookId) {
    return favorites.any((book) => book.bookId == bookId);
  }
}

final class FavoritesFailure extends FavoritesState {
  final String errorMessage;

  FavoritesFailure({required this.errorMessage});
}
