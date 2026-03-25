import 'dart:async';
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    final currentState = context.read<BooksListingBloc>().state;
    final hasReachedMax =
        currentState is BooksListingLoaded && currentState.hasReachedMax;
    if (!_scrollController.hasClients ||
        (currentState is BooksListingLoaded && currentState.isLoadingMore) ||
        hasReachedMax) {
      return;
    }

    final threshold = _scrollController.position.maxScrollExtent - 150;
    if (_scrollController.position.pixels < threshold) return;

    context.read<BooksListingBloc>().add(
      FetchBooksListing(
        startIndex: (currentState is BooksListingLoaded
            ? currentState.books.length
            : 0),
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
        if (state is! BooksListingLoaded ||
            state.loadMoreErrorMessage == null ||
            state.loadMoreErrorMessage!.isEmpty) {
          return;
        }

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(state.loadMoreErrorMessage!)));
      },
      builder: (context, state) {
        if (state is BooksListingFailure) {
          return Center(child: Text(state.errorMessage));
        }

        if (state is BookListingEmpty) {
          return Center(child: Text(state.message));
        }

        if (state is BooksListingLoading) {
          return ModalProgressHUD(
            inAsyncCall: true,
            progressIndicator: CircularProgressIndicator(color: kPrimaryColor),
            child: Container(),
          );
        }

        if (state is BooksListingLoaded) {
          _isLoadingMore = false;
          final screenWidth = MediaQuery.sizeOf(context).width;
          final maxTileWidth = screenWidth >= 1200
              ? 300.0
              : screenWidth >= 800
              ? 260.0
              : 220.0;
          final childAspectRatio = screenWidth >= 1200
              ? 0.98
              : screenWidth >= 800
              ? 0.92
              : 0.86;

          return ModalProgressHUD(
            inAsyncCall: state.isRefreshing,
            progressIndicator: CircularProgressIndicator(color: kPrimaryColor),
            child: Stack(
              children: [
                RefreshIndicator(
                  color: kPrimaryColor,
                  onRefresh: () async {
                    final completer = Completer();
                    StreamSubscription? subscription;

                    subscription = context
                        .read<BooksListingBloc>()
                        .stream
                        .listen((state) {
                          if (state is BooksListingLoaded &&
                              !state.isRefreshing) {
                            completer.complete();
                            subscription?.cancel();
                          }
                          if (state is BooksListingFailure) {
                            completer.complete();
                            subscription?.cancel();
                          }
                        });

                    context.read<BooksListingBloc>().add(
                      FetchBooksListing(forceRefresh: true, startIndex: 0),
                    );

                    return completer.future;
                  },
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth >= 800 ? 24 : 12,
                      vertical: 12,
                    ),
                    itemCount: state.books.length,
                    controller: _scrollController,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: maxTileWidth,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemBuilder: (context, index) {
                      final book = state.books[index];

                      return CustomCard(book: book);
                    },
                  ),
                ),
                if (state.isLoadingMore)
                  const Positioned(
                    left: 0,
                    right: 0,
                    bottom: 16,
                    child: Center(child: CircularProgressIndicator()),
                  ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
