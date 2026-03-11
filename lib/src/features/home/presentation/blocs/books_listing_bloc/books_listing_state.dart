part of 'books_listing_bloc.dart';

@immutable
sealed class BooksListingState {}

final class BooksListingInitial extends BooksListingState {}

final class BooksListingLoading extends BooksListingState {}

final class BooksListingLoaded extends BooksListingState {
  final List<BookEntity> books;
  final bool isRefreshing;

  BooksListingLoaded({required this.books, this.isRefreshing = false});

  BooksListingLoaded copyWith({
    List<BookEntity>? books,
    bool? isRefreshing,
  }) {
    return BooksListingLoaded(
      books: books ?? this.books,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }
}

final class BooksListingFailure extends BooksListingState {
  final String errorMessage;

  BooksListingFailure({required this.errorMessage});
}
