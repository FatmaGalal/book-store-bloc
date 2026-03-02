import 'package:book_store/src/core/constants/constants.dart';
import 'package:book_store/src/features/home/presentation/widgets/custom_card.dart';
import 'package:book_store/src/features/home/presentation/providers/books_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class BooksListView extends ConsumerStatefulWidget {
  const BooksListView({super.key});

  @override
  ConsumerState<BooksListView> createState() => _BooksListPageState();
}

class _BooksListPageState extends ConsumerState<BooksListView> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(booksListProvider.notifier).fetchBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(booksListProvider);

    if (state.error != null) {
      return Scaffold(body: Center(child: Text(state.error!)));
    }

    return ModalProgressHUD(
      inAsyncCall: state.isLoading,
      progressIndicator: CircularProgressIndicator(color: kPrimaryColor),
      child: RefreshIndicator(
        color: kPrimaryColor,
        onRefresh: () async {
          await ref.read(booksListProvider.notifier).refreshBooks();
        },
        child: GridView.builder(
          itemCount: state.books.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            final book = state.books[index];

            return CustomCard(book: book);
          },
        ),
      ),
    );
  }
}
