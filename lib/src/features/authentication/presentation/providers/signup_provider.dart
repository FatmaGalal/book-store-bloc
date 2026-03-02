import 'package:book_store/src/features/authentication/data/models/signup_state.dart';
import 'package:book_store/src/features/authentication/presentation/providers/auth_providers.dart';
import 'package:book_store/src/features/authentication/presentation/providers/validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signUpProvider =
    StateNotifierProvider<SignUpController, AsyncValue<void>>((ref) {
      return SignUpController(ref);
    });

class SignUpController extends StateNotifier<AsyncValue<void>> {
  SignUpController(this.ref) : super(const AsyncData(null));

  final Ref ref;

  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  SignUpState formState = const SignUpState();

  void updateEmail(String value) {
    formState = formState.copyWith(email: value);
    emailError = Validators.email(value);
  }

  void updatePassword(String value) {
    formState = formState.copyWith(password: value);
    passwordError = Validators.password(value);
    confirmPasswordError = Validators.confirmPassword(
      formState.confirmPassword,
      value,
    );
  }

  void updateConfirmPassword(String value) {
    formState = formState.copyWith(confirmPassword: value);
    confirmPasswordError = Validators.confirmPassword(
      value,
      formState.password,
    );
  }

  bool validateForm() {
    emailError = Validators.email(formState.email);
    passwordError = Validators.password(formState.password);
    confirmPasswordError = Validators.confirmPassword(
      formState.confirmPassword,
      formState.password,
    );

    return emailError == null &&
        passwordError == null &&
        confirmPasswordError == null;
  }

  Future<void> registerNewUser() async {
    if (!validateForm()) {
      state = AsyncError("Validation failed", StackTrace.current);
      return;
    }

    state = const AsyncLoading();

    try {
      await ref
          .read(authServiceProvider)
          .registerNewUser(
            email: formState.email.trim(),
            password: formState.password.trim(),
          );

      state = const AsyncData(null);
    } catch(error,stackTrace){
      state=AsyncError(error, stackTrace);
    }
  }
}
