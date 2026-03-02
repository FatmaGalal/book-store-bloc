import 'package:book_store/src/features/home/domain/entities/book_entity.dart';

class BooksListState {
  final bool isLoading;
  final List<BookEntity> books;
  final String? error;

  const BooksListState({
    this.isLoading = false,
    this.books = const [],
    this.error,
  });

  BooksListState copyWith({
    bool? isLoading,
    List<BookEntity>? books,
    String? error,
  }) {
    return BooksListState(
      isLoading: isLoading ?? this.isLoading,
      books: books ?? this.books,
      error: error,
    );
  }
}