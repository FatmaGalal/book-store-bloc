import 'package:book_store/l10n/app_localizations.dart';
import 'package:book_store/src/core/constants/constants.dart';
import 'package:book_store/src/core/utils/assets_data.dart';
import 'package:book_store/src/features/home/domain/entities/book_entity.dart';
import 'package:book_store/src/features/home/presentation/widgets/book_details_info_row.dart';
import 'package:book_store/src/features/home/presentation/widgets/favorite_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookDatilsBody extends ConsumerStatefulWidget {
  const BookDatilsBody({super.key});

  @override
  ConsumerState<BookDatilsBody> createState() => _BookDatilsBodyState();
}

class _BookDatilsBodyState extends ConsumerState<BookDatilsBody> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = AppLocalizations.of(context)!;
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final book = ModalRoute.of(context)!.settings.arguments as BookEntity;

    String valueOrUnknown(String? value, String fallback) {
      if (value == null || value.trim().isEmpty) return fallback;
      return value;
    }

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// --- Small Cover ---
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 90,
                  height: 130,

                  child: book.imageLink != null
                      ? Image.network(book.imageLink!, fit: BoxFit.cover)
                      : Image.asset(AssetsData.book),
                ),
              ),

              const SizedBox(width: 16),

              /// --- Main Info ---
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      valueOrUnknown(book.title, t.unknown),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color:colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      valueOrUnknown(book.authors, t.unknown),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),

                    /// --- FAVORITE BUTTON ---
                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: kPrimaryColorTransparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            valueOrUnknown(book.categories, t.general),
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        FavoritIcon(book: book),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          /// --- DETAILS SECTION ---
          InfoRow(
            icon: Icons.business,
            label: t.publisher,
            value: (book.publisher?.isNotEmpty ?? false)
                ? book.publisher!
                : t.unknown,
          ),

          const SizedBox(height: 10),

          InfoRow(
            icon: Icons.calendar_today,
            label: t.published,
            value: valueOrUnknown(book.publishedDate, t.unknown),
          ),

          const SizedBox(height: 10),

          InfoRow(
            icon: Icons.language,
            label: t.language,
            value: book.language?.toUpperCase() ?? t.unknown,
          ),

          const SizedBox(height: 20),

          Divider(color: theme.dividerColor),

          const SizedBox(height: 12),

          Text( '${t.bookId}: ${book.bookId}'),
        ],
      ),
    );
  }
}
