import 'package:book_store/src/core/constants/constants.dart';
import 'package:book_store/src/features/home/presentation/blocs/books_listing_bloc/books_listing_bloc.dart';
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
    return BlocBuilder<BooksListingBloc, BooksListingState>(
      builder: (context, state) {
        if (state is BooksListingFailure) {
          return Center(child: Text(state.errorMessage));
        }

        if (state is BooksListingLoading) {
          return ModalProgressHUD(
            inAsyncCall: true,
            progressIndicator: CircularProgressIndicator(color: kPrimaryColor),
            child: Container(),
          );
        }

        if (state is BooksListingLoaded) {
          return ModalProgressHUD(
            inAsyncCall: state.isRefreshing,
            progressIndicator: CircularProgressIndicator(color: kPrimaryColor),
            child: RefreshIndicator(
              color: kPrimaryColor,
              onRefresh: () async {
                context.read<BooksListingBloc>().add(
                  FetchBooksListing(forceRefresh: true),
                );
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
        return const SizedBox.shrink();
      },
    );
  }
}
