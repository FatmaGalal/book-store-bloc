import 'package:book_store/src/core/constants/constants.dart';
import 'package:book_store/src/features/home/presentation/blocs/books_listing_bloc/books_listing_bloc.dart';
import 'package:book_store/src/features/home/presentation/widgets/custom_card.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class BooksListView extends StatefulWidget {
  const BooksListView({super.key});

  @override
  State<BooksListView> createState() => _BooksListPageState();
}

class _BooksListPageState extends State<BooksListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (!_scrollController.hasClients) return;
    final currentState = context.read<BooksListingBloc>().state;
    if (currentState is! BooksListingLoaded) return;
    if (currentState.hasReachedMax || currentState.isLoadingMore) {
      return;
    }

    final threshold = _scrollController.position.maxScrollExtent - 150;
    if (_scrollController.position.pixels < threshold) return;

    context.read<BooksListingBloc>().add(
      FetchBooksListing(
        startIndex: currentState.books.length,
        forceRefresh: true,
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BooksListingBloc, BooksListingState>(
      listener: (context, state) {
        if (state is BooksListingLoaded &&
            state.loadMoreErrorMessage != null &&
            state.loadMoreErrorMessage!.isNotEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.loadMoreErrorMessage!)));
        }
      },
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
            inAsyncCall: state.isRefreshing || state.isLoadingMore,
            progressIndicator: CircularProgressIndicator(color: kPrimaryColor),
            child: RefreshIndicator(
              color: kPrimaryColor,
              onRefresh: () async {
                final completer = Completer<void>();
                context.read<BooksListingBloc>().add(
                  FetchBooksListing(forceRefresh: true, completer: completer),
                );
                await completer.future;
              },
              child: GridView.builder(
                itemCount: state.books.length,
                controller: _scrollController,
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
