import 'package:book_store/src/core/constants/constants.dart';
import 'package:book_store/src/features/home/presentation/blocs/favorites_bloc/favorites_bloc.dart';
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
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesBooksLoaded && state.favorites.isEmpty) {
          return const Center(child: Text('No favorite books yet'));
        }
        return ModalProgressHUD(
          inAsyncCall: state is FavoritesBooksLoaded ? false : true,
          progressIndicator: CircularProgressIndicator(color: kPrimaryColor),
          child: GridView.builder(
            itemCount: state is FavoritesBooksLoaded
                ? state.favorites.length
                : 0,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              final book = state is FavoritesBooksLoaded
                  ? state.favorites[index]
                  : null;

              return book != null ? CustomCard(book: book) : SizedBox.shrink();
            },
          ),
        );
      },
    );
  }
}
