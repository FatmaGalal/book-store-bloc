import 'package:book_store/l10n/app_localizations.dart';
import 'package:book_store/src/core/components/custom_button.dart';
import 'package:book_store/src/core/components/language_switch_button.dart';
import 'package:book_store/src/core/helpers/show_snak_bar_message.dart';
import 'package:book_store/src/features/authentication/presentation/cubits/signup_cubit/signup_cubit.dart';
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
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupFailure) {
          showMessage(context, state.errorMessage);
        } else if (state is SignupSuccess) {
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
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            textFieldHint: t.emailHint,
                            onChanged: (data) {
                              _email = data;
                            },
                            validator: Validators.email,
                          ),

                          SizedBox(height: 12),

                          CustomFormTextfield(
                            textFieldHint: t.passwordHint,
                            textInputAction: TextInputAction.next,
                            onChanged: (data) {
                              _password = data;
                            },
                            obscureText: true,
                            validator: Validators.password,
                          ),

                          SizedBox(height: 12),

                          CustomFormTextfield(
                            textFieldHint: t.confirmPasswordHint,
                            textInputAction: TextInputAction.done,
                            obscureText: true,
                            validator: (confirmPassword) =>
                                Validators.confirmPassword(
                                  confirmPassword,
                                  _password,
                                ),
                          ),

                          SizedBox(height: 24),

                          CustomButton(
                            buttonText: t.signupTitle,
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                await context.read<SignupCubit>().signUp(
                                  email: _email,
                                  password: _password,
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
