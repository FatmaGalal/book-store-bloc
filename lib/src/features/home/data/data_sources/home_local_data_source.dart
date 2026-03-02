import 'package:book_store/src/core/constants/constants.dart';
import 'package:book_store/src/features/home/domain/entities/book_entity.dart';
import 'package:hive/hive.dart';

abstract class HomeLocalDataSource {
  List<BookEntity> fetchBookList();
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  @override
  List<BookEntity> fetchBookList() {
   List<BookEntity> booksList=[];
    var books = Hive.box<BookEntity>(kBookBox);
    booksList = books.values.toList();
    return booksList;
  }
}