import 'package:book_store/l10n/app_localizations.dart';
import 'package:book_store/src/core/components/custom_button.dart';
import 'package:book_store/src/core/components/language_switch_button.dart';
import 'package:book_store/src/core/helpers/show_snak_bar_message.dart';
import 'package:book_store/src/features/authentication/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:book_store/src/features/authentication/presentation/validators.dart';
import 'package:book_store/src/features/authentication/presentation/widgets/custom_form_textfield.dart';
import 'package:book_store/src/core/constants/constants.dart';
import 'package:book_store/src/core/utils/assets_data.dart';
import 'package:book_store/src/features/authentication/presentation/pages/signup_page.dart';
import 'package:book_store/src/features/home/presentation/pages/book_listing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          showMessage(context, state.errorMessage);
        }
        if (state is LoginSuccess) {
          Navigator.pushReplacementNamed(context, BookListingPage.id);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is LoginLoading,
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
                            controller: emailController,
                            validator: Validators.requiredField,
                            textFieldHint: t.emailHint,
                          ),

                          SizedBox(height: 12),

                          CustomFormTextfield(
                            controller: passwordController,
                            validator: Validators.requiredField,
                            textFieldHint: t.passwordHint,
                            obscureText: true,
                          ),

                          SizedBox(height: 24),

                          CustomButton(
                            buttonText: t.loginTitle,
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                context.read<LoginBloc>().add(
                                  LoginRequested(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                );
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
      },
    );
  }
}
