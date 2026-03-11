import 'package:book_store/l10n/app_localizations.dart';
import 'package:book_store/src/core/components/custom_button.dart';
import 'package:book_store/src/core/components/language_switch_button.dart';
import 'package:book_store/src/core/helpers/show_snak_bar_message.dart';
import 'package:book_store/src/features/authentication/presentation/blocs/signup_bloc/signup_bloc.dart';
import 'package:book_store/src/features/authentication/presentation/validators.dart';
import 'package:book_store/src/features/authentication/presentation/widgets/custom_form_textfield.dart';
import 'package:book_store/src/core/constants/constants.dart';
import 'package:book_store/src/core/utils/assets_data.dart';
import 'package:book_store/src/features/authentication/presentation/pages/login_page.dart';
import 'package:book_store/src/features/home/presentation/pages/book_listing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return BlocConsumer<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupFailure) {
          showMessage(context, state.errorMessage);
        }
        if (state is SignupSuccess) {
          Navigator.pushReplacementNamed(context, BookListingPage.id);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is SignupLoading,
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
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            textFieldHint: t.emailHint,

                            validator: (email) {
                              return Validators.email(email);
                            },
                          ),

                          SizedBox(height: 12),

                          CustomFormTextfield(
                            controller: passwordController,
                            textFieldHint: t.passwordHint,
                            textInputAction: TextInputAction.next,
                            obscureText: true,
                            validator: (password) {
                              return Validators.password(password);
                            },
                          ),

                          SizedBox(height: 12),

                          CustomFormTextfield(
                            controller: confirmPasswordController,
                            textFieldHint: t.confirmPasswordHint,
                            textInputAction: TextInputAction.done,
                            obscureText: true,
                            validator: (confirmPassword) {
                              return Validators.confirmPassword(
                                confirmPassword,
                                passwordController.text,
                              );
                            },
                          ),

                          SizedBox(height: 24),
                          CustomButton(
                            buttonText: t.signupTitle,
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                context.read<SignupBloc>().add(
                                  SignupRequested(
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
      },
    );
  }
}
