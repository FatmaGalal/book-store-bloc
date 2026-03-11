import 'package:book_store/src/core/constants/route_constants.dart';
import 'package:book_store/src/features/authentication/presentation/blocs/signup_bloc/signup_bloc.dart';
import 'package:book_store/src/features/authentication/presentation/widgets/signup_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});
  static String id = RouteConstants.signUpPage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignupBloc(),
      child: Scaffold(body: SafeArea(child: SignUpBody())),
    );
  }
}
