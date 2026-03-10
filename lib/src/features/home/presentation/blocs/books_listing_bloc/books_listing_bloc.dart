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
    on<BooksListingEvent>(_onFetchBooksListing);
  }

  Future<void> _onFetchBooksListing(
    BooksListingEvent event,
    Emitter<BooksListingState> emit,
  ) async {
    // if (event is FetchBooksListing) {
    emit(BooksListingLoading());
    final result = await fetchBookListUseCase();
    result.fold(
      (failure) => emit(BooksListingFailure(errorMessage: failure.message)),
      (books) => emit(BooksListingLoaded(books: books)),
    );
  }

  //}
}
