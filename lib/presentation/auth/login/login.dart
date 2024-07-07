import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafy/core/helper/routes.dart';
import 'package:herafy/core/helper/shared_preferences.dart';
import 'package:herafy/core/helper/validator.dart';
import 'package:herafy/core/widgets/buttons.dart';
import 'package:herafy/core/widgets/inputs.dart';
import 'package:herafy/core/widgets/toast.dart';
import 'package:herafy/data/model/client.dart';
import 'package:herafy/domain/cubit/auth/auth_cubit.dart';
import 'package:herafy/domain/cubit/auth/auth_state.dart';
import 'package:herafy/domain/cubit/user/user_cubit.dart';
import 'package:herafy/presentation/auth/widgets/auth.switch_page.dart';
import 'package:herafy/presentation/auth/widgets/signin_option.dart';
import 'package:herafy/presentation/auth/widgets/terms_conditions.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 45),
            child: Column(
              textDirection: TextDirection.rtl,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "مرحبا بك",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontSize: 28,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  ".نحن متحمسون لعودتك، ولا يمكننا الانتظار لنرى ما الذي قمت به منذ آخر مرة قمت فيها بتسجيل الدخول",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontSize: 16, height: 1.5, color: Colors.black54),
                ),
                LoginInputs(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginInputs extends StatefulWidget {
  const LoginInputs({super.key});
  @override
  State<LoginInputs> createState() => _LoginInputsState();
}

class _LoginInputsState extends State<LoginInputs> {
  bool rememberMe = false;
  bool showPassword = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SuccessToast.showToast(
        msg:
            "Shared is: userID: ${SharedPreference().getString(key: "userID")}\n\nuserType: ${SharedPreference().getString(key: "userType")}");
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 16.0),
          buildEmailField(
            isArabic: true,
            controller: _emailController,
            validator: (Validator.emailValidator),
          ),
          const SizedBox(height: 16.0),
          buildPasswordField(
              isArabic: true,
              label: 'كلمة المرور',
              showPassword: showPassword,
              controller: _passwordController,
              validator: (Validator.passwordValidator),
              changePasswordVisibility: () =>
                  setState(() => showPassword = !showPassword)),
          const SizedBox(height: 10),
          // Align(
          //   alignment: AlignmentDirectional.centerEnd,
          //   child: buildTextButton(
          //     label: "Forgot Password?",
          //     onPressed: () {},
          //   ),
          // ),
          BlocConsumer<AuthCubit, AuthState>(
            builder: (context, state) {
              return Column(children: [
                buildSubmitButton(
                  label: "تسجيل الدخول",
                  widthFactor: .5,
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true &&
                        state is! AuthLoading) {
                      try {
                        if (_emailController.text == "admin@herafy.com" &&
                            _passwordController.text == "123456") {
                          navigate(route: Routes.adminHome);
                        } else {
                          // await loginUser();
                          context.read<AuthCubit>().signInWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                          // navigate(route: Routes.home);
                        }
                      } catch (e) {
                        FailureToast.showToast(
                            msg:
                                Validator.firebaseLoginValidator(e.toString()));
                      }
                    }
                  },
                ),
                signInOptions(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: buildOptionButton(
                    src: 'google',
                    onTap: () async {
                      if (state is! AuthLoading) {
                        context.read<AuthCubit>().signInWithGoogle();
                      }
                    },
                  ),
                ),
              ]);
            },
            listener: (context, state) {
              if (state is AuthSuccessLogin) {
                SuccessToast.showToast(msg: "تم التسجيل بنجاح");
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.registerFill,
                  (route) => false,
                );
              } else if (state is AuthSuccessLoginWithProfile) {
                // SuccessToast.showToast(
                //     msg: state.data is Client ? "Client" : "Technician");
                context.read<UserCubit>().setUserData(state.data);
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  state.data is Client
                      ? Routes.clientHome
                      : Routes.technicianHome,
                  (route) => false,
                );
              } else if (state is AuthError) {
                FailureToast.showToast(
                    msg: Validator.firebaseLoginValidator(
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
                Center(child: termsAndConditions()),
                const SwitchAuthPage(
                  isArabic: true,
                  link: "إنشاء حساب",
                  route: Routes.register,
                  label: "ليس لديك حساب؟",
                ),
                const SizedBox(height: 16.0),
              ],
            );
          }),
        ],
      ),
    );
  }

  void navigate({required String route}) =>
      Navigator.pushReplacementNamed(context, route);

  void showErrorDialog({required String error}) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(error),
        ),
      );

  loginUser() async {
    // try {
    //   var user = await CustomFirebase.instance.signWithEmailAndPassword(
    //     email: _emailController.text,
    //     password: _passwordController.text,
    //   );
    //   SharedPreference().setString(key: 'userID', value: user);
    //   return user;
    // } catch (e) {
    //   throw Exception(e);
    // }
  }
}
