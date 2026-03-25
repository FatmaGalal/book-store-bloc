import 'package:book_store/src/core/constants/api_constants.dart';
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
  int _nextStartIndex = ApiConstants.maxResults;
  bool _isLoadingMore = false;

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (!_scrollController.hasClients || _isLoadingMore) return;

    final threshold = _scrollController.position.maxScrollExtent - 150;
    if (_scrollController.position.pixels < threshold) return;

    _isLoadingMore = true;
    context.read<BooksListingBloc>().add(
      FetchBooksListing(startIndex: _nextStartIndex, forceRefresh: true),
    );
    _nextStartIndex += ApiConstants.maxResults;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BooksListingBloc, BooksListingState>(
      builder: (context, state) {
        if (state is BooksListingFailure) {
          _isLoadingMore = false;
          return Center(child: Text(state.errorMessage));
        }

        if (state is BooksListingLoading) {
          _isLoadingMore = false;
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
            child: RefreshIndicator(
              color: kPrimaryColor,
              onRefresh: () async {
                _nextStartIndex = ApiConstants.maxResults;
                context.read<BooksListingBloc>().add(
                  FetchBooksListing(forceRefresh: true),
                );
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
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
