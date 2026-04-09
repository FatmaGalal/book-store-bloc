import 'package:book_store/src/core/components/safe_network_image.dart';
import 'package:book_store/src/core/constants/constants.dart';
import 'package:book_store/src/core/utils/assets_data.dart';
import 'package:book_store/src/core/utils/responsive_scale.dart';
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
    final screenWidth = MediaQuery.sizeOf(context).width;
    double scaleFactor = getScalingFactor(
      context,
    ); // Ensure scaling factor is calculated f
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, BookDetailsPage.id, arguments: book);
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: isDark ? kDarkModeShadwColor : kLightModeShadwColor,
              spreadRadius: 0,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: Card(
          elevation: 3,
          margin: EdgeInsets.zero,
          color: isDark ? kDarkBGColor : kLightBGColor,
          child: Padding(
            padding: EdgeInsets.all(12 * scaleFactor),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final imageSize = (constraints.maxHeight * 0.4).clamp(
                  60.0,
                  100.0,
                );

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SafeNetworkImage(
                        imageUrl: book.imageLink,
                        fallbackAssetPath: AssetsData.book,
                        height: imageSize.toDouble(),
                        width: imageSize.toDouble(),
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: 12 * scaleFactor),
                    Text(
                      book.title ?? '',
                      maxLines: screenWidth >= 800 ? 3 : 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: FavoritIcon(book: book),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
