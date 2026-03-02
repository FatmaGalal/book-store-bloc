import 'package:book_store/src/core/constants/route_constants.dart';
import 'package:book_store/src/features/home/presentation/widgets/book_listing_body.dart';
import 'package:flutter/material.dart';

class BookListingPage extends StatelessWidget{
  const BookListingPage({super.key});
  static String id = RouteConstants.bookListingPage;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      body: SafeArea(child:BookListingBody()));
  }
}