import 'package:book_store/src/core/constants/api_constants.dart';
import 'package:book_store/src/core/services/api_service.dart';
import 'package:book_store/src/features/home/data/data_sources/save_books.dart';
import 'package:book_store/src/features/home/data/models/book_model.dart';
import 'package:book_store/src/features/home/domain/entities/book_entity.dart';

abstract class HomeRemoteDataSource {
  Future<List<BookEntity>> fetchBookList({required int startIndex});
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiService apiService;

  HomeRemoteDataSourceImpl({required this.apiService});
  @override
  Future<List<BookEntity>> fetchBookList({required int startIndex}) async {
    var response = await apiService.get(
      endPoint: ApiConstants.bookList,
      startIndex: startIndex,
      queryParameters: {
        'q': ApiConstants.defaultQuery,
        'maxResults': ApiConstants.maxResults,
      },
    );

    List<BookEntity> books = [];

    final items = response['items'] as List?;

    if (items == null) {
      return [];
    }

    books = items.map((bookMap) => BookModel.fromJson(bookMap)).toList();
    await saveAllBooks(books, replace: startIndex == 0);
    return books;
  }
}
