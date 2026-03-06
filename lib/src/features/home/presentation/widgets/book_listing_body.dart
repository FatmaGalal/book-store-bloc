import 'package:book_store/l10n/app_localizations.dart';
import 'package:book_store/src/core/components/custom_app_bar.dart';
import 'package:book_store/src/core/services/setup_home_service.dart';
import 'package:book_store/src/features/home/data/repos/home_repo_impl.dart';
import 'package:book_store/src/features/home/domain/use_cases/fetch_book_list_use_case.dart';
import 'package:book_store/src/features/home/presentation/cubits/books_listing_cubits/books_listing_cubit.dart';
import 'package:book_store/src/features/home/presentation/pages/favorite_books_page.dart';
import 'package:book_store/src/features/home/presentation/widgets/book_listing_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookListingBody extends StatelessWidget {
  const BookListingBody({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CustomAppBar(
            title: t.appTitle,

            onPress: () {
              Navigator.pushNamed(context, FavoriteBooksPage.id);
            },
          ),

          BlocProvider(
            create: (context) {
              return BooksListingCubit(
                FetchBookListUseCase(homeRepo: getIt.get<HomeRepoImpl>()),
              )..fetchBooks();
            },
            child: Expanded(child: BooksListView()),
          ),
        ],
      ),
    );
  }
}
