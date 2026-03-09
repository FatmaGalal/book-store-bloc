import 'package:book_store/src/features/authentication/data/auth_service.dart';
import 'package:book_store/src/features/authentication/domain/firebase_auth_errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.auth) : super(LoginInitial());
  final AuthService auth;

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await auth.signIn(email: email, password: password);

      // If login is successful, emit LoginSuccess
      emit(LoginSuccess());
    } on FirebaseAuthException catch (error) {
      // If there's a FirebaseAuthException, emit LoginFailure with the error message
      emit(LoginFailure(errorMessage: firebaseAuthError(error)));
    } catch (e) {
      // If there's an error during login, emit LoginFailure with the error message
      emit(LoginFailure(errorMessage: 'Something went wrong'));
    }
  }
}
