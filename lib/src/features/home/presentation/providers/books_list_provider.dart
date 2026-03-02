import 'package:book_store/src/features/home/presentation/providers/books_list_states.dart';
import 'package:book_store/src/features/home/domain/repos/home_repo.dart';
import 'package:book_store/src/features/home/data/repos/home_repo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final booksListProvider = StateNotifierProvider<BooksNotifier, BooksListState>(
  (ref) => BooksNotifier(ref.read(homeRepoProvider)),
);

class BooksNotifier extends StateNotifier<BooksListState> {
  final HomeRepo homeRepo;

  //BooksNotifier(this.homeRepo) : super(const BooksListState());
  BooksNotifier(this.homeRepo) : super(const BooksListState()) {
    fetchBooks();
  }

  Future<void> fetchBooks() async { 
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, error: null);

    final result = await homeRepo.fetchBookList(
      forceRefresh: false,
    );

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
      },
      (books) {
        state = state.copyWith(isLoading: false, books: books);
      },
    );
  }


   Future<void> refreshBooks() async {
   
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, error: null);

    final result = await homeRepo.fetchBookList(
      forceRefresh: true, 
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
      (books) {
        state = state.copyWith(
          isLoading: false,
          books: books,
          error: null,
        );
      },
    );
  }
}