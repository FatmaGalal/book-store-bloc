part of 'books_listing_bloc.dart';

@immutable
sealed class BooksListingEvent {}

class FetchBooksListing extends BooksListingEvent {
  final bool forceRefresh;
  final int startIndex;

  bool get isLoadingMore => startIndex > 0;
  bool get isRefreshing => !isLoadingMore && forceRefresh;

  FetchBooksListing({this.forceRefresh = false, this.startIndex = 0});
}
