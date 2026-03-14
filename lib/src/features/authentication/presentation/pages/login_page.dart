import 'package:book_store/src/core/constants/route_constants.dart';
import 'package:book_store/src/features/authentication/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:book_store/src/features/authentication/presentation/widgets/login_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static String id = RouteConstants.loginPage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: Scaffold(body: SafeArea(child: LoginBody())),
    );
  }
}
