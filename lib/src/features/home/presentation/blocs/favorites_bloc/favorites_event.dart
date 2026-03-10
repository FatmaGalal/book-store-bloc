part of 'favorites_bloc.dart';

@immutable
sealed class FavoritesEvent {}

class LoadFavorites extends FavoritesEvent {}

class ToggleFavorite extends FavoritesEvent {
  final BookEntity book;

  ToggleFavorite({required this.book});
}
