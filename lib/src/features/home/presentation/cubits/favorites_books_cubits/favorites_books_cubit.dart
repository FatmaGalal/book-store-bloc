import 'package:book_store/src/core/constants/constants.dart';
import 'package:book_store/src/features/home/domain/entities/book_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

part 'favorites_books_state.dart';

class FavoritesBooksCubit extends Cubit<FavoritesBooksState> {
  FavoritesBooksCubit() : super(FavoritesBooksInitial()) {
    loadFavoriteBooks();
  }

  Box<BookEntity> get _box {
    return Hive.box<BookEntity>(kfavoriteBooksBox);
  }

  List<BookEntity> loadFavoriteBooks() {
    final favoriteBooks = _box.values.toList();
    emit(FavoritesBooksLoaded(favoriteBooks));
    return favoriteBooks;
  }

  bool isFavorite(String bookId) {
    if (state is FavoritesBooksLoaded) {
      final books = (state as FavoritesBooksLoaded).favoriteBooks;
      return books.any((book) => book.bookId == bookId);
    }
    return false;
  }

  Future<void> toggleFavorites(BookEntity book) async {
    if (_box.containsKey(book.bookId)) {
      await _box.delete(book.bookId);
    } else {
      await _box.put(book.bookId, book);
    }

    loadFavoriteBooks();
  }
}
