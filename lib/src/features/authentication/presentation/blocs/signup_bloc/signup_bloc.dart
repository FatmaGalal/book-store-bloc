import 'package:book_store/src/core/services/setup_dependencies.dart';
import 'package:book_store/src/features/authentication/data/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupRequested>((event, emit) async {
      emit(SignupLoading());

      try {
        await getIt.get<AuthService>().registerNewUser(
          email: event.email,
          password: event.password,
        );

        emit(SignupSuccess());
      } catch (e) {
        emit(SignupFailure(e.toString()));
      }
    });
  }
}
