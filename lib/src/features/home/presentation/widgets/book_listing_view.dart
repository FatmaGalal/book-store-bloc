import 'package:book_store/src/core/constants/constants.dart';
import 'package:book_store/src/features/home/presentation/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class BooksListView extends StatefulWidget {
  const BooksListView({super.key});

  @override
  State<BooksListView> createState() => _BooksListPageState();
}

class _BooksListPageState extends State<BooksListView> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
  

    return ModalProgressHUD(
      inAsyncCall:false,
      progressIndicator: CircularProgressIndicator(color: kPrimaryColor),
      child: RefreshIndicator(
        color: kPrimaryColor,
        onRefresh: () async {
      
        },
        child: GridView.builder(
          //itemCount: state.books.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            //final book = state.books[index];

           // return CustomCard(book: book);
          },
        ),
      ),
    );
  }
}
