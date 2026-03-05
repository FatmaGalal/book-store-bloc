import 'package:book_store/src/core/constants/constants.dart';
import 'package:book_store/src/features/home/presentation/cubits/favorites_books_cubits/favorites_books_cubit.dart';
import 'package:book_store/src/features/home/presentation/pages/favorite_books_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarkIcon extends StatelessWidget {
  const BookmarkIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context
        .read<FavoritesBooksCubit>()
        .loadFavoriteBooks()
        .toList();

    if (favorites.isNotEmpty) {
      return BlocBuilder<FavoritesBooksCubit, FavoritesBooksState>(
        builder: (context, state) {
          return IconButton(
            onPressed: () {
              Navigator.pushNamed(context, FavoriteBooksPage.id);
            },
            icon: Icon(Icons.bookmark, color: kPrimaryColor, size: 35),
          );
        },
      );
    } else {
      return IconButton(
        onPressed: () {},
        icon: Icon(Icons.bookmark, color: kIconDimmedColor1, size: 35),
      );
    }
  }
}
