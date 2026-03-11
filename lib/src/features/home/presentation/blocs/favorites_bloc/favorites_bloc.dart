import 'package:book_store/src/features/home/domain/entities/book_entity.dart';
import 'package:book_store/src/features/home/domain/use_cases/load_favorites_use_case.dart';
import 'package:book_store/src/features/home/domain/use_cases/toggle_favorite_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc({
    required this.loadFavoritesUseCase,
    required this.toggleFavoriteUseCase,
  }) : super(FavoritesInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  final LoadFavoritesUseCase loadFavoritesUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;

  bool isFavorite(String bookId) {
    if (state is FavoritesBooksLoaded) {
      final books = (state as FavoritesBooksLoaded).favorites;
      return books.any((book) => book.bookId == bookId);
    }
    return false;
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    final result = await loadFavoritesUseCase();
    result.fold(
      (failure) => emit(FavoritesFailure(errorMessage: failure.message)),
      (favorites) => emit(FavoritesBooksLoaded(favorites)),
    );
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<FavoritesState> emit,
  ) async {
    final result = await toggleFavoriteUseCase(event.book);
    result.fold(
      (failure) => emit(FavoritesFailure(errorMessage: failure.message)),
      (favorites) => emit(FavoritesBooksLoaded(favorites)),
    );
  }
}
