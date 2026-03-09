import 'package:book_store/src/core/constants/route_constants.dart';
import 'package:book_store/src/core/services/setup_dependencies.dart';
import 'package:book_store/src/features/authentication/data/auth_service.dart';
import 'package:book_store/src/features/authentication/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:book_store/src/features/authentication/presentation/widgets/login_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static String id = RouteConstants.loginPage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(getIt.get<AuthService>()),
      child: Scaffold(body: SafeArea(child: LoginBody())),
    );
  }
}
