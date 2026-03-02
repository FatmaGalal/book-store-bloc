import 'package:book_store/src/core/constants/constants.dart';
import 'package:book_store/src/features/home/domain/entities/book_entity.dart';
import 'package:book_store/src/features/home/presentation/providers/favorites_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritIcon extends StatelessWidget {
  const FavoritIcon({
    super.key,
    required this.book,
  });

  final BookEntity book;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    return Consumer(
      builder: (context, ref, _) {
        ref.watch(favoritesProvider);
    
        final notifier = ref.read(
          favoritesProvider.notifier,
        );
    
        final isFav = notifier.isFavorite(book.bookId);
    
        return IconButton(
          icon: Icon(
            isFav
                ? Icons.favorite
                : Icons.favorite_border,
            color: isFav
                ? kIconActiveColor1
                : isDark?kLightBGColor: kIconDimmedColor1,
          ),
          onPressed: () {
            notifier.toggleFavorite(book);
          },
        );
      },
    );
  }
}
