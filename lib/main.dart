import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafy/core/helper/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:herafy/core/helper/firebase_options.dart';
<<<<<<< HEAD
import 'package:herafy/presentation/admin/admin_home/admin_home.dart';
=======
import 'package:herafy/core/helper/shared_preferences.dart';
import 'package:herafy/domain/cubit/auth/auth_cubit.dart';
>>>>>>> dad19b8c8d08809f8715abd8c9b38683f318c8ec
import 'package:herafy/presentation/auth/login/login.dart';
import 'package:herafy/presentation/auth/signup/register.dart';
import 'package:herafy/presentation/auth/signup/register_fill.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPreference.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Herafy',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        locale: const Locale("ar"),
        routes: {
          Routes.login: (context) => const LoginPage(),
          Routes.register: (context) => const RegisterationPage(),
          Routes.registerFill: (context) => const RegisterFillData(),
        },
        initialRoute: Routes.login,
        // home: const LoginPage(),
      ),
<<<<<<< HEAD
      locale: const Locale("ar"),
      routes: {
        Routes.login: (context) => const LoginPage(),
        Routes.register: (context) => const RegisterationPage(),
        Routes.registerFill: (context) => const RegisterFillData(),
        Routes.adminHome: (context) => const AdminHome(),
      },
      initialRoute: Routes.login,
      
=======
>>>>>>> dad19b8c8d08809f8715abd8c9b38683f318c8ec
    );
  }
}
