import 'package:book_store/l10n/app_localizations.dart';
import 'package:book_store/src/core/components/custom_button.dart';
import 'package:book_store/src/core/components/language_switch_button.dart';
import 'package:book_store/src/core/helpers/show_snak_bar_message.dart';
import 'package:book_store/src/features/authentication/domain/firebase_auth_errors.dart';
import 'package:book_store/src/features/authentication/presentation/providers/login_provider.dart';
import 'package:book_store/src/features/authentication/presentation/providers/validators.dart';
import 'package:book_store/src/features/authentication/presentation/widgets/custom_form_textfield.dart';
import 'package:book_store/src/core/constants/constants.dart';
import 'package:book_store/src/core/utils/assets_data.dart';
import 'package:book_store/src/features/authentication/presentation/pages/signup_page.dart';
import 'package:book_store/src/features/home/presentation/pages/book_listing_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginBody extends ConsumerStatefulWidget {
  const LoginBody({super.key});

  @override
  ConsumerState<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends ConsumerState<LoginBody> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(loginProvider);
    final t = AppLocalizations.of(context)!;
    ref.listen(loginProvider, (previous, next) {
      next.whenOrNull(
        data: (data) {
          Navigator.pushReplacementNamed(context, BookListingPage.id);
        },
        error: (ex, st) {
          if (ex is FirebaseAuthException) {
            showMessage(context, firebaseAuthError(ex));
          } else {
            showMessage(context, ex.toString());
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
                        validator: Validators.requiredField,
                        textFieldHint: t.emailHint,
                        onChanged: (data) {
                          ref.read(loginProvider.notifier).updateEmail(data);
                        },
                      ),

                      SizedBox(height: 12),

                      CustomFormTextfield(
                        validator: Validators.requiredField,
                        textFieldHint: t.passwordHint,
                        onChanged: (data) {
                          ref.read(loginProvider.notifier).updatePassword(data);
                        },
                        obscureText: true,
                      ),

                      SizedBox(height: 24),

                      CustomButton(
                        buttonText: t.loginTitle,
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            ref.read(loginProvider.notifier).login();
                          }
                        },
                      ),

                      SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            t.noAccount,
                            style: TextStyle(
                              fontSize: 16,
                              color: kPrimaryColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                SignUpPage.id,
                              );
                            },
                            child: Text(
                              ' ${t.signupTitle}',
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
