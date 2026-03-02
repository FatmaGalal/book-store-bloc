import 'package:book_store/l10n/app_localizations.dart';
import 'package:book_store/src/core/components/custom_app_bar.dart';
import 'package:book_store/src/core/constants/route_constants.dart';
import 'package:book_store/src/features/home/presentation/pages/book_listing_page.dart';
import 'package:book_store/src/features/home/presentation/widgets/favorite_book_body.dart';
import 'package:flutter/material.dart';

class FavoriteBooksPage extends StatelessWidget {
  const FavoriteBooksPage({super.key});
  static const id = RouteConstants.favoritesPage;
  @override
  Widget build(BuildContext context) {
    final localized = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              CustomAppBar(
                title: localized.favoritesTitle,
                hasBackButton: true,
                hasIcon: false,
                onBackPressed: () {
                  Navigator.pop(context, BookListingPage.id);
                },
              ),

              Expanded(child: FavoriteBookBody()),
            ],
          ),
        ),
      ),
    );
  }
}
