part of 'books_listing_cubit.dart';

@immutable
sealed class BooksListingState {}

final class BooksListingInitial extends BooksListingState {}

final class BooksListingLoading extends BooksListingState {}

final class BooksListingFailure extends BooksListingState {
  final String errorMessage;
  BooksListingFailure(this.errorMessage);
}

final class BooksListingSuccess extends BooksListingState {
  final List<BookEntity> books;
  BooksListingSuccess(this.books);
}
