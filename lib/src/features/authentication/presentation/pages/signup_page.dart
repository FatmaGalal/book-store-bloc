import 'package:book_store/src/core/constants/route_constants.dart';
import 'package:book_store/src/core/services/setup_dependencies.dart';
import 'package:book_store/src/features/authentication/data/auth_service.dart';
import 'package:book_store/src/features/authentication/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:book_store/src/features/authentication/presentation/widgets/signup_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});
  static String id = RouteConstants.signUpPage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(getIt<AuthService>()),
      child: Scaffold(body: SafeArea(child: SignUpBody())),
    );
  }
}
