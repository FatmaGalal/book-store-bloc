import 'package:book_store/src/core/constants/constants.dart';
import 'package:book_store/src/features/home/presentation/blocs/favorites_bloc/favorites_bloc.dart';
import 'package:book_store/src/features/home/presentation/pages/favorite_books_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarkIcon extends StatelessWidget {
  const BookmarkIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        final favorites = state is FavoritesBooksLoaded ? state.favorites : [];

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
    
  
  // else {
  //   return IconButton(
  //     onPressed: () {},
  //     icon: Icon(Icons.bookmark, color: kIconDimmedColor1, size: 35),
  //   );
  // }



