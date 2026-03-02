import 'package:book_store/src/features/authentication/data/models/login_state.dart';
import 'package:book_store/src/features/authentication/presentation/providers/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider =
    StateNotifierProvider<LoginController, AsyncValue<void>>((ref) {
  return LoginController(ref);
});

class LoginController extends StateNotifier<AsyncValue<void>> {
  LoginController(this.ref) : super(const AsyncData(null));

  final Ref ref;

  LoginState formState = const LoginState();

  void updateEmail(String value) {
    formState = formState.copyWith(email: value);
  }

  void updatePassword(String value) {
    formState = formState.copyWith(password: value);
  }

  Future<void> login() async {
    state = const AsyncLoading();

    try {
      await ref.read(authServiceProvider).signIn(
            email: formState.email.trim(),
            password: formState.password.trim(),
          );

      state = const AsyncData(null);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}
