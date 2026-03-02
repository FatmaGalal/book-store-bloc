import 'package:book_store/l10n/app_localizations.dart';
import 'package:book_store/src/core/components/custom_app_bar.dart';
import 'package:book_store/src/core/constants/route_constants.dart';
import 'package:book_store/src/features/home/presentation/pages/book_listing_page.dart';
import 'package:book_store/src/features/home/presentation/pages/favorite_books_page.dart';
import 'package:book_store/src/features/home/presentation/widgets/book_datils_body.dart';
import 'package:flutter/material.dart';

class BookDetailsPage extends StatelessWidget {
  const BookDetailsPage({super.key});
  static String id = RouteConstants.bookDetailsgPage;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              CustomAppBar(
                title: t.appTitle,
                hasBackButton: true,
                onBackPressed: () {
                  Navigator.pop(context, BookListingPage.id);
                },

                //icon: Icons.bookmark,
                onPress: () {
                  Navigator.pushNamed(context, FavoriteBooksPage.id);
                },
              ),

              Expanded(child: BookDatilsBody()),
            ],
          ),
        ),
      ),
    );
  }
}
