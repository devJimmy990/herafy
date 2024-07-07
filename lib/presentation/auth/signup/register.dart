import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafy/core/helper/routes.dart';
import 'package:herafy/core/widgets/inputs.dart';
import 'package:herafy/core/widgets/buttons.dart';
import 'package:herafy/core/helper/validator.dart';
import 'package:herafy/core/widgets/check_box.dart';
import 'package:herafy/core/widgets/toast.dart';
import 'package:herafy/domain/cubit/auth/auth_cubit.dart';
import 'package:herafy/domain/cubit/auth/auth_state.dart';
import 'package:herafy/presentation/auth/widgets/signin_option.dart';
import 'package:herafy/presentation/auth/widgets/terms_conditions.dart';
import 'package:herafy/presentation/auth/widgets/auth.switch_page.dart';

class RegisterationPage extends StatefulWidget {
  const RegisterationPage({super.key});

  @override
  State<RegisterationPage> createState() => _RegisterationPageState();
}

class _RegisterationPageState extends State<RegisterationPage> {
  bool showBoth = false;
  bool showPassword = false;
  bool showRePassword = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            child: Form(
              key: _formKey,
              child: Column(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildEmailField(
                    isArabic: true,
                    controller: _emailController,
                    validator: (Validator.emailValidator),
                  ),
                  const SizedBox(height: 16.0),
                  buildPasswordField(
                    isArabic: true,
                    label: 'كلمة المرور',
                    showPassword: showBoth ? true : showPassword,
                    controller: _passwordController,
                    validator: (Validator.passwordValidator),
                    changePasswordVisibility: () => setState(() {
                      showPassword = !showPassword;
                      if (showBoth) {
                        showRePassword = showBoth = false;
                      }
                    }),
                  ),
                  const SizedBox(height: 16.0),
                  buildPasswordField(
                    isArabic: true,
                    label: 'تأكيد كلمة المرور',
                    showPassword: showBoth ? true : showRePassword,
                    controller: _rePasswordController,
                    validator: (value) => Validator.rePasswordValidator(
                        value, _passwordController.text),
                    changePasswordVisibility: () => setState(() {
                      showRePassword = !showRePassword;
                      if (showBoth) {
                        showPassword = showBoth = false;
                      }
                    }),
                  ),
                  customCheckBox(
                    value: showBoth,
                    label: "إظهار كلمة المرور",
                    onChanged: (val) => setState(() {
                      showBoth = val ??= false;
                      if (!showBoth) {
                        showPassword = showRePassword = false;
                      }
                    }),
                  ),
                  const SizedBox(height: 8.0),
                  BlocConsumer<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return buildSubmitButton(
                        widthFactor: .5,
                        label: "إنشاء حساب",
                        onPressed: () async {
                          if (_formKey.currentState?.validate() == true &&
                              state is! AuthLoading) {
                            context
                                .read<AuthCubit>()
                                .createAccountWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                          }
                        },
                      );
                    },
                    listener: (context, state) {
                      if (state is AuthAccountCreated) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.registerFill,
                          (route) => false,
                        );
                      } else if (state is AuthError) {
                        FailureToast.showToast(
                            msg: Validator.firebaseRegisterValidator(
                          state.message,
                        ));
                      }
                    },
                  ),
                  const SizedBox(height: 8.0),
                  BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
                    if (state is AuthLoading) {
                      return const CircularProgressIndicator();
                    }
                    return Column(
                      children: [
                        signInOptions(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: buildOptionButton(
                            src: 'google',
                            onTap: () async {},
                          ),
                        ),
                        Center(child: termsAndConditions()),
                        const SwitchAuthPage(
                          isArabic: true,
                          link: " تسجيل الدخول",
                          route: Routes.login,
                          label: "هل لديك حساب بالفعل؟",
                        ),
                        const SizedBox(height: 16.0),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void navigate({required String route}) =>
      Navigator.pushReplacementNamed(context, route);

  void showErrorDialog({required String error}) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(error),
          ));

  void createNewUser() async {
    // try {
    //   var user =
    //       await CustomFirebase.instance.createAccountWithEmailAndPassword(
    //     email: _emailController.text,
    //     password: _passwordController.text,
    //   );
    //   await SharedPreference().setString(key: 'userID', value: user);
    // } catch (e) {
    //   // print(e);
    //   showErrorDialog(error: Validator.firebaseRegisterValidator(e.toString()));
    // }
  }
}
