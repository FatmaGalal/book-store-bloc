import 'package:book_store/l10n/app_localizations.dart';
import 'package:book_store/src/core/components/custom_button.dart';
import 'package:book_store/src/core/components/language_switch_button.dart';
import 'package:book_store/src/features/authentication/domain/firebase_auth_errors.dart';
import 'package:book_store/src/features/authentication/presentation/providers/signup_provider.dart';
import 'package:book_store/src/features/authentication/presentation/widgets/custom_form_textfield.dart';
import 'package:book_store/src/core/constants/constants.dart';
import 'package:book_store/src/core/utils/assets_data.dart';
import 'package:book_store/src/core/helpers/show_snak_bar_message.dart';
import 'package:book_store/src/features/authentication/presentation/pages/login_page.dart';
import 'package:book_store/src/features/home/presentation/pages/book_listing_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpBody extends ConsumerStatefulWidget {
  const SignUpBody({super.key});

  @override
  ConsumerState<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends ConsumerState<SignUpBody> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(signUpProvider);
    final t = AppLocalizations.of(context)!;
    ref.listen(signUpProvider, (previous, next) {
      next.whenOrNull(
        data: (data) {
          Navigator.pushReplacementNamed(context, BookListingPage.id);
        },
        error: (ex, st) {
          if (ex is FirebaseAuthException) {
            showMessage(context, firebaseAuthError(ex));
          }
        },
      );
    });

    return ModalProgressHUD(
      inAsyncCall: provider.isLoading,
      progressIndicator: CircularProgressIndicator(color: kPrimaryColor),
      child: Stack(
        children: [
          PositionedDirectional(
            top: 12,
            end: 12,
            child: LanguageSwitchButton()),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      SizedBox(
                        height: 170,
                        child: Image.asset(AssetsData.logo),
                      ),

                      SizedBox(height: 24),

                      CustomFormTextfield(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        textFieldHint: t.emailHint,
                        onChanged: (data) {
                          ref.read(signUpProvider.notifier).updateEmail(data);
                        },
                        validator: (email) =>
                            ref.read(signUpProvider.notifier).emailError,
                      ),

                      SizedBox(height: 12),

                      CustomFormTextfield(
                        textFieldHint: t.passwordHint,
                        textInputAction: TextInputAction.next,
                        onChanged: (data) {
                          ref
                              .read(signUpProvider.notifier)
                              .updatePassword(data);
                        },
                        obscureText: true,
                        validator: (password) =>
                            ref.read(signUpProvider.notifier).passwordError,
                      ),

                      SizedBox(height: 12),

                      CustomFormTextfield(
                        textFieldHint: t.confirmPasswordHint,
                        textInputAction: TextInputAction.done,
                        onChanged: (data) {
                          ref
                              .read(signUpProvider.notifier)
                              .updateConfirmPassword(data);
                        },

                        obscureText: true,
                        validator: (confirmPassword) => ref
                            .read(signUpProvider.notifier)
                            .confirmPasswordError,
                      ),

                      SizedBox(height: 24),

                      CustomButton(
                        buttonText: t.signupTitle,
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await ref
                                .read(signUpProvider.notifier)
                                .registerNewUser();
                          }
                        },
                      ),

                      SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            t.haveAccount,
                            style: TextStyle(
                              fontSize: 16,
                              color: kPrimaryColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                LoginPage.id,
                              );
                            },
                            child: Text(
                              ' ${t.loginTitle}',
                              style: TextStyle(
                                fontSize: 18,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
