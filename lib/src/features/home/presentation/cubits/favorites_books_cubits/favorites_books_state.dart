part of 'favorites_books_cubit.dart';

@immutable
sealed class FavoritesBooksState {}

final class FavoritesBooksInitial extends FavoritesBooksState {}

final class FavoritesBooksLoaded extends FavoritesBooksState {
  final List<BookEntity> favoriteBooks;
  FavoritesBooksLoaded(this.favoriteBooks);
}
