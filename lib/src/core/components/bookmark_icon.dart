import 'package:book_store/src/core/constants/constants.dart';
import 'package:book_store/src/features/home/presentation/pages/favorite_books_page.dart';
import 'package:book_store/src/features/home/presentation/providers/favorites_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookmarkIcon extends StatelessWidget {
  const BookmarkIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        ref.watch(favoritesProvider);

        ref.read(favoritesProvider.notifier);

        final favorites = ref.watch(favoritesProvider);

        if (favorites.isNotEmpty) {
          return IconButton(
            onPressed: () {
              Navigator.pushNamed(context, FavoriteBooksPage.id);
            },
            icon: Icon(Icons.bookmark, color: kPrimaryColor, size: 35),
          );
        } else {
          return IconButton(
            onPressed: () {},
            icon: Icon(Icons.bookmark, color: kIconDimmedColor1, size: 35),
          );
        }
      },
    );
  }
}
