import 'package:book_store/l10n/app_localizations.dart';
import 'package:book_store/src/core/constants/constants.dart';
import 'package:book_store/src/features/home/domain/entities/book_entity.dart';
import 'package:book_store/src/features/home/presentation/cubits/books_listing_cubits/books_listing_cubit.dart';
import 'package:book_store/src/features/home/presentation/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class BooksListView extends StatefulWidget {
  const BooksListView({super.key});

  @override
  State<BooksListView> createState() => _BooksListPageState();
}

class _BooksListPageState extends State<BooksListView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BooksListingCubit, BooksListingState>(
      builder: (context, state) {
        final isLoading = state is BooksListingLoading;
        List<BookEntity> books = state is BooksListingSuccess
            ? state.books
            : [];

        return ModalProgressHUD(
          inAsyncCall: isLoading,
          progressIndicator: CircularProgressIndicator(color: kPrimaryColor),
          child: RefreshIndicator(
            color: kPrimaryColor,
            onRefresh: () => context.read<BooksListingCubit>().fetchBooks(),
            child: _buildBooksContent(state, books),
          ),
        );
      },
    );
  }

  Widget _buildBooksContent(BooksListingState state, List<BookEntity> books) {
    final t = AppLocalizations.of(context)!;
    if (state is BooksListingFailure) {
      return Center(
        child: Text(state.errorMessage, textAlign: TextAlign.center),
      );
    }

    if (state is BooksListingSuccess && books.isEmpty) {
      return Center(child: Text(t.nobooksfound, textAlign: TextAlign.center));
    }

    return GridView.builder(
      itemCount: books.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        final book = books[index];
        return CustomCard(book: book);
      },
    );
  }
}
