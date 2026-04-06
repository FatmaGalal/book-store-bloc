part of 'books_listing_bloc.dart';

@immutable
sealed class BooksListingState {}

final class BooksListingInitial extends BooksListingState {}

final class BooksListingLoading extends BooksListingState {}

final class BooksListingLoaded extends BooksListingState {
  final List<BookEntity> books;
  final bool isRefreshing;
  final bool isLoadingMore;
  final bool hasReachedMax;
  final String? loadMoreErrorMessage;

  BooksListingLoaded({
    required this.books,
    this.isRefreshing = false,
    this.isLoadingMore = false,
    this.hasReachedMax = false,
    this.loadMoreErrorMessage,
  });

  BooksListingLoaded copyWith({
    List<BookEntity>? books,
    bool? isRefreshing,
    bool? isLoadingMore,
    bool? hasReachedMax,
    String? loadMoreErrorMessage,
    bool clearLoadMoreError = false,
  }) {
    return BooksListingLoaded(
      books: books ?? this.books,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      loadMoreErrorMessage: clearLoadMoreError
          ? null
          : loadMoreErrorMessage ?? this.loadMoreErrorMessage,
    );
  }
}

final class BooksListingFailure extends BooksListingState {
  final String errorMessage;

  BooksListingFailure({required this.errorMessage});
}
