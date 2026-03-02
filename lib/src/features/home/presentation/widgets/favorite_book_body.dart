import 'package:book_store/src/core/constants/constants.dart';
import 'package:book_store/src/features/home/presentation/providers/favorites_provider.dart';
import 'package:book_store/src/features/home/presentation/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class FavoriteBookBody extends ConsumerStatefulWidget {
  const FavoriteBookBody({super.key});

  @override
  ConsumerState<FavoriteBookBody> createState() => _FavoriteBookBodyState();
}

class _FavoriteBookBodyState extends ConsumerState<FavoriteBookBody> {
  @override
  Widget build(BuildContext context) {
   
    final favorites = ref.watch(favoritesProvider);
   
    return ModalProgressHUD(
      inAsyncCall: false,
      progressIndicator: CircularProgressIndicator(color: kPrimaryColor),
      child: GridView.builder(
        itemCount: favorites.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          final book = favorites[index];

          return CustomCard(book: book);
        },
      ),
    );
  }
}
