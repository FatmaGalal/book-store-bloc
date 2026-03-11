import 'package:book_store/src/core/constants/constants.dart';
import 'package:book_store/src/features/home/domain/entities/book_entity.dart';
import 'package:hive/hive.dart';

abstract class HomeLocalDataSource {
  List<BookEntity> fetchBookList();
  List<BookEntity> loadFavorites();
  Future<List<BookEntity>> toggleFavorite(BookEntity book);
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  @override
  List<BookEntity> fetchBookList() {
    List<BookEntity> booksList = [];
    var books = Hive.box<BookEntity>(kBookBox);
    booksList = books.values.toList();
    return booksList;
  }

  @override
  List<BookEntity> loadFavorites() {
    final favoritesBox = Hive.box<BookEntity>(kfavoriteBooksBox);
    return favoritesBox.values.toList();
  }

  @override
  Future<List<BookEntity>> toggleFavorite(BookEntity book) async {
    final favoritesBox = Hive.box<BookEntity>(kfavoriteBooksBox);

    if (favoritesBox.containsKey(book.bookId)) {
      await favoritesBox.delete(book.bookId);
    } else {
      await favoritesBox.put(book.bookId, book);
    }

    return favoritesBox.values.toList();
  }
}
