import 'package:book_store/src/core/constants/constants.dart';
import 'package:book_store/src/features/home/domain/entities/book_entity.dart';
import 'package:hive/hive.dart';

void saveAllBooks(List<BookEntity> books) {
  var box = Hive.box<BookEntity>(kBookBox);
  box.addAll(books);
}

void saveBook(BookEntity book) {
  var box = Hive.box<BookEntity>(kBookBox);
  box.add(book);
}
