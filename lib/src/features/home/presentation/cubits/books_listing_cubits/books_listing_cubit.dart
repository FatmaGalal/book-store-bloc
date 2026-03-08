import 'package:book_store/src/features/home/domain/entities/book_entity.dart';
import 'package:book_store/src/features/home/domain/use_cases/fetch_book_list_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'books_listing_state.dart';

class BooksListingCubit extends Cubit<BooksListingState> {
  BooksListingCubit(this.fetchBookListUseCase) : super(BooksListingInitial());
  final FetchBookListUseCase fetchBookListUseCase;
  Future<void> fetchBooks() async {
    emit(BooksListingLoading());

    final result = await fetchBookListUseCase.call();
    result.fold(
      (failure) => emit(BooksListingFailure(failure.message)),
      (books) => emit(BooksListingSuccess(books)),
    );
  }
}
