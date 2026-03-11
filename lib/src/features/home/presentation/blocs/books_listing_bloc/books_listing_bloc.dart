import 'dart:async';
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

    if (event.forceRefresh && previousLoadedState != null) {
      emit(previousLoadedState.copyWith(isRefreshing: true));
    } else {
      emit(BooksListingLoading());
    }

    final result = await fetchBookListUseCase(event.forceRefresh);
    result.fold(
      (failure) {
        if (previousLoadedState != null) {
          emit(previousLoadedState.copyWith(isRefreshing: false));
          return;
        }

        emit(BooksListingFailure(errorMessage: failure.message));
      },
      (books) => emit(BooksListingLoaded(books: books)),
    );
  }
}
