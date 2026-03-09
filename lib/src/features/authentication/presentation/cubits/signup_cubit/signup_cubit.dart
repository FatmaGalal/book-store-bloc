import 'package:book_store/src/features/authentication/data/auth_service.dart';
import 'package:book_store/src/features/authentication/domain/firebase_auth_errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.auth) : super(SignupInitial());

  final AuthService auth;

  Future<void> signUp({required String email, required String password}) async {
    emit(SignupLoading());
    try {
      await auth.registerNewUser(email: email, password: password);

      // If signup is successful, emit SignupSuccess
      emit(SignupSuccess());
    } on FirebaseAuthException catch (error) {
      emit(SignupFailure(errorMessage: firebaseAuthError(error)));
    } catch (e) {
      emit(SignupFailure(errorMessage: 'Something went wrong'));
    }
  }
}
