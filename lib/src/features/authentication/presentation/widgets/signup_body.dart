import 'package:book_store/l10n/app_localizations.dart';
import 'package:book_store/src/core/components/custom_button.dart';
import 'package:book_store/src/core/components/language_switch_button.dart';
import 'package:book_store/src/features/authentication/presentation/widgets/custom_form_textfield.dart';
import 'package:book_store/src/core/constants/constants.dart';
import 'package:book_store/src/core/utils/assets_data.dart';
import 'package:book_store/src/features/authentication/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return ModalProgressHUD(
      inAsyncCall: true,
      progressIndicator: CircularProgressIndicator(color: kPrimaryColor),
      child: Stack(
        children: [
          PositionedDirectional(
            top: 12,
            end: 12,
            child: LanguageSwitchButton(),
          ),
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
                        onChanged: (data) {},
                        validator: (email) {},
                      ),

                      SizedBox(height: 12),

                      CustomFormTextfield(
                        textFieldHint: t.passwordHint,
                        textInputAction: TextInputAction.next,
                        onChanged: (data) {},
                        obscureText: true,
                        validator: (password) {},
                      ),

                      SizedBox(height: 12),

                      CustomFormTextfield(
                        textFieldHint: t.confirmPasswordHint,
                        textInputAction: TextInputAction.done,
                        onChanged: (data) {},

                        obscureText: true,
                        validator: (confirmPassword) {},
                      ),

                      SizedBox(height: 24),

                      CustomButton(
                        buttonText: t.signupTitle,
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                           //TODO: Call SignUp Page
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
