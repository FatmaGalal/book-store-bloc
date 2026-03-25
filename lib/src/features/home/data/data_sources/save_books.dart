import 'package:book_store/src/core/constants/constants.dart';
import 'package:book_store/src/features/home/domain/entities/book_entity.dart';
import 'package:hive/hive.dart';

Future<void> saveAllBooks(
  List<BookEntity> books, {
  bool replace = false,
}) async {
  var box = Hive.box<BookEntity>(kBookBox);
  if (replace) {
    await box.clear();
  }
  await box.addAll(books);
}

Future<void> saveBook(BookEntity book) async {
  var box = Hive.box<BookEntity>(kBookBox);
  await box.add(book);
}
