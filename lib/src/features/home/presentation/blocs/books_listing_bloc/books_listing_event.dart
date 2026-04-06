part of 'books_listing_bloc.dart';

@immutable
sealed class BooksListingEvent {}

class FetchBooksListing extends BooksListingEvent {
  final bool forceRefresh;
  final int startIndex;
  final Completer<void>? completer;

  bool get isLoadMore => startIndex > 0;
  bool get isRefresh => !isLoadMore && forceRefresh;

  FetchBooksListing({
    this.forceRefresh = false,
    this.startIndex = 0,
    this.completer,
  });
}
