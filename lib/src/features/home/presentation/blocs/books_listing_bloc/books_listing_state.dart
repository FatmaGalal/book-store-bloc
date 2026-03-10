part of 'books_listing_bloc.dart';

@immutable
sealed class BooksListingState {}

final class BooksListingInitial extends BooksListingState {}

final class BooksListingLoading extends BooksListingState {}

final class BooksListingLoaded extends BooksListingState {
  final List<BookEntity> books;

  BooksListingLoaded({required this.books});
}

final class BooksListingSuccess extends BooksListingState {}

final class BooksListingFailure extends BooksListingState {
  final String errorMessage;

  BooksListingFailure({required this.errorMessage});
}
