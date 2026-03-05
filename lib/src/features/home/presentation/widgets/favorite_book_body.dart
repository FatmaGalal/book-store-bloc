import 'package:book_store/src/core/constants/constants.dart';
import 'package:book_store/src/features/home/presentation/cubits/favorites_books_cubits/favorites_books_cubit.dart';
import 'package:book_store/src/features/home/presentation/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class FavoriteBookBody extends StatefulWidget {
  const FavoriteBookBody({super.key});

  @override
  State<FavoriteBookBody> createState() => _FavoriteBookBodyState();
}

class _FavoriteBookBodyState extends State<FavoriteBookBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBooksCubit, FavoritesBooksState>(
      builder: (context, state) {
        final favorites = context
            .read<FavoritesBooksCubit>()
            .loadFavoriteBooks()
            .toList();
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
      },
    );
  }
}
