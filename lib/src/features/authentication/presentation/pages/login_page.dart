import 'package:book_store/src/core/constants/route_constants.dart';
import 'package:book_store/src/features/authentication/presentation/widgets/login_body.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static String id = RouteConstants.loginPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: LoginBody()));
  }
}
