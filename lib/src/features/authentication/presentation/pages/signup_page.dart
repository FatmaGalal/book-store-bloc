import 'package:book_store/src/core/constants/route_constants.dart';
import 'package:book_store/src/features/authentication/presentation/widgets/signup_body.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});
  static String id = RouteConstants.signUpPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: SignUpBody()));
  }
}
