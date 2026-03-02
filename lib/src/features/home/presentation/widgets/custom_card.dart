import 'package:book_store/src/core/constants/constants.dart';
import 'package:book_store/src/features/home/domain/entities/book_entity.dart';
import 'package:book_store/src/features/home/presentation/pages/book_details_page.dart';
import 'package:book_store/src/features/home/presentation/widgets/favorite_icon_widget.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final BookEntity book;

  const CustomCard({required this.book, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          BookDetailsPage.id,
          arguments: book,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: isDark ? kDarkModeShadwColor : kLightModeShadwColor,
                    spreadRadius: 0,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
              height: 200,
              width: 200,
              child: Card(
                elevation: 3,
                color: isDark? kDarkBGColor: kLightBGColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        book.title!,
                        maxLines: 2,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Text('', style: TextStyle(color:isDark ?kLightModeShadwColor: kTextDarkColor )),

                          FavoritIcon(book: book),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              left: 70,
              bottom: 100,
              child: Image.network(book.imageLink ?? '', height: 80, width: 80),
            ),
          ],
        ),
      ),
    );
  }
}
