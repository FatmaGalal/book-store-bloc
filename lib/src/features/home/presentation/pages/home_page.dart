import 'package:book_store/src/core/constants/route_constants.dart';
import 'package:book_store/src/features/home/presentation/widgets/home_view_body.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static String id = RouteConstants.homePage;
  @override
  Widget build(BuildContext context) {
    return HomeViewBody();
  }
}
