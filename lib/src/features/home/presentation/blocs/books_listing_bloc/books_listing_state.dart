part of 'books_listing_bloc.dart';

@immutable
sealed class BooksListingState {}

final class BooksListingInitial extends BooksListingState {}

final class BookListingEmpty extends BooksListingState {
  final String message;

  BookListingEmpty({required this.message});
}

final class BooksListingLoading extends BooksListingState {}

final class BooksListingLoaded extends BooksListingState {
  final List<BookEntity> books;
  final bool isRefreshing;
  final bool hasReachedMax;
  final bool isLoadingMore;
  // final String? loadMoreErrorMessage;

  BooksListingLoaded({
    required this.books,
    this.isRefreshing = false,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
    // this.loadMoreErrorMessage
  });

  BooksListingLoaded copyWith({
    List<BookEntity>? books,
    bool? isRefreshing,
    bool? hasReachedMax,
    bool? isLoadingMore,
    // String? loadMoreErrorMessage,
  }) {
    return BooksListingLoaded(
      books: books ?? this.books,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      // loadMoreErrorMessage: loadMoreErrorMessage ?? this.loadMoreErrorMessage,
    );
  }
}

final class BooksListingFailure extends BooksListingState {
  final String errorMessage;

  BooksListingFailure({required this.errorMessage});
}
