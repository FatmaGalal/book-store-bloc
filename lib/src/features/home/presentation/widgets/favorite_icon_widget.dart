import 'package:book_store/src/core/constants/constants.dart';
import 'package:book_store/src/features/home/domain/entities/book_entity.dart';
import 'package:book_store/src/features/home/presentation/blocs/favorites_bloc/favorites_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritIcon extends StatelessWidget {
  const FavoritIcon({super.key, required this.book});

  final BookEntity book;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        final isFav = state is FavoritesBooksLoaded
            ? state.isFavorite(book.bookId)
            : false;
        return IconButton(
          icon: Icon(
            isFav ? Icons.favorite : Icons.favorite_border,
            color: isFav
                ? kIconActiveColor1
                : isDark
                ? kLightBGColor
                : kIconDimmedColor1,
          ),
          onPressed: () {
            return BlocProvider.of<FavoritesBloc>(
              context,
            ).add(ToggleFavorite(book: book));
          },
        );
      },
    );
  }
}
