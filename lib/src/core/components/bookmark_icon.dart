import 'package:book_store/src/core/constants/constants.dart';
import 'package:book_store/src/features/home/presentation/pages/favorite_books_page.dart';
import 'package:flutter/material.dart';

class BookmarkIcon extends StatelessWidget {
  const BookmarkIcon({super.key});

  @override
  Widget build(BuildContext context) {

     final favorites = [];

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
  }
}

