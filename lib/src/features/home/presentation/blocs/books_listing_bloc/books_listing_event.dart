part of 'books_listing_bloc.dart';

@immutable
sealed class BooksListingEvent {}

class FetchBooksListing extends BooksListingEvent {
  final bool forceRefresh;

  FetchBooksListing({this.forceRefresh = false});
}
