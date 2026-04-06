import 'dart:async';
import 'package:book_store/src/core/constants/api_constants.dart';
import 'package:book_store/src/features/home/domain/entities/book_entity.dart';
import 'package:book_store/src/features/home/domain/use_cases/fetch_book_list_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'books_listing_event.dart';
part 'books_listing_state.dart';

class BooksListingBloc extends Bloc<BooksListingEvent, BooksListingState> {
  final FetchBookListUseCase fetchBookListUseCase;

  BooksListingBloc({required this.fetchBookListUseCase})
    : super(BooksListingInitial()) {
    on<FetchBooksListing>(_onFetchBooksListing);
  }

  Future<void> _onFetchBooksListing(
    FetchBooksListing event,
    Emitter<BooksListingState> emit,
  ) async {
    final previousLoadedState = state is BooksListingLoaded
        ? state as BooksListingLoaded
        : null;

    try {
      if (event.isLoadMore && previousLoadedState != null) {
        if (previousLoadedState.isLoadingMore ||
            previousLoadedState.hasReachedMax) {
          return;
        }

        emit(
          previousLoadedState.copyWith(
            isLoadingMore: true,
            clearLoadMoreError: true,
          ),
        );
      } else if (event.isRefresh && previousLoadedState != null) {
        emit(
          previousLoadedState.copyWith(
            isRefreshing: true,
            hasReachedMax: false,
            clearLoadMoreError: true,
          ),
        );
      } else {
        emit(BooksListingLoading());
      }

      final result = await fetchBookListUseCase(
        event.forceRefresh,
        event.startIndex,
      );
      result.fold(
        (failure) {
          if (previousLoadedState != null) {
            emit(
              previousLoadedState.copyWith(
                isRefreshing: false,
                isLoadingMore: false,
                loadMoreErrorMessage: event.isLoadMore ? failure.message : null,
                clearLoadMoreError: !event.isLoadMore,
              ),
            );
            return;
          }

          emit(BooksListingFailure(errorMessage: failure.message));
        },
        (books) {
          final reachedMaxForPage =
              books.isEmpty || books.length < ApiConstants.maxResults;

          if (!event.isLoadMore || previousLoadedState == null) {
            emit(
              BooksListingLoaded(
                books: books,
                hasReachedMax: reachedMaxForPage,
              ),
            );
            return;
          }

          final existingIds = previousLoadedState.books
              .map((book) => book.bookId)
              .toSet();
          final newBooks = books
              .where((book) => !existingIds.contains(book.bookId))
              .toList();
          emit(
            previousLoadedState.copyWith(
              books: [...previousLoadedState.books, ...newBooks],
              isLoadingMore: false,
              hasReachedMax:
                  previousLoadedState.hasReachedMax || reachedMaxForPage,
              clearLoadMoreError: true,
            ),
          );
        },
      );
    } finally {
      if (event.completer?.isCompleted == false) {
        event.completer?.complete();
      }
    }
  }
}
