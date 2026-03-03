import 'package:book_store/src/core/constants/constants.dart';
import 'package:book_store/src/features/home/domain/entities/book_entity.dart';
import 'package:flutter/material.dart';

class FavoritIcon extends StatelessWidget {
  const FavoritIcon({super.key, required this.book});

  final BookEntity book;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final bool isFav = true;

    return IconButton(
      icon: Icon(
        isFav ? Icons.favorite : Icons.favorite_border,
        color: isFav
            ? kIconActiveColor1
            : isDark
            ? kLightBGColor
            : kIconDimmedColor1,
      ),
      onPressed: () {},
    );
  }
}
