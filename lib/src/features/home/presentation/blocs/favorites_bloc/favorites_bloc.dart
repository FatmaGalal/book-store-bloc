import 'package:book_store/src/core/constants/constants.dart';
import 'package:book_store/src/features/home/domain/entities/book_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  final Box<BookEntity> box = Hive.box<BookEntity>(kfavoriteBooksBox);

  List<BookEntity> _readFavoritesFromStorage() {
    return box.values.toList();
  }

  dynamic _findBookKey(String bookId) {
    for (final key in box.keys) {
      final currentBook = box.get(key);
      if (currentBook?.bookId == bookId) {
        return key;
      }
    }
    return null;
  }

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
    emit(FavoritesBooksLoaded(_readFavoritesFromStorage()));
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<FavoritesState> emit,
  ) async {
    final existingKey = _findBookKey(event.book.bookId);

    if (existingKey != null) {
      await box.delete(existingKey);
    } else {
      await box.put(event.book.bookId, event.book);
    }

    emit(FavoritesBooksLoaded(_readFavoritesFromStorage()));
  }
}
