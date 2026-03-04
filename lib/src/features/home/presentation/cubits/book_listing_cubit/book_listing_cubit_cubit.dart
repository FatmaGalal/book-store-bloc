import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'book_listing_cubit_state.dart';

class BookListingCubitCubit extends Cubit<BookListingCubitState> {
  BookListingCubitCubit() : super(BookListingCubitInitial());
}
