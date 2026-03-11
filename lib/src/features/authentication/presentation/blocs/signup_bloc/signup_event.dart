part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

class SignupRequested extends SignupEvent {
  final String email;
  final String password;

  SignupRequested({required this.email, required this.password});
}
