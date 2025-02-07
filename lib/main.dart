import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafy/core/helper/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:herafy/core/helper/firebase_options.dart';
import 'package:herafy/domain/cubit/order/order_cubit.dart';
import 'package:herafy/domain/cubit/user/user_cubit.dart';
import 'package:herafy/presentation/admin/admin_home/admin_home.dart';
import 'package:herafy/core/helper/shared_preferences.dart';
import 'package:herafy/domain/cubit/auth/auth_cubit.dart';
import 'package:herafy/presentation/auth/login/login.dart';
import 'package:herafy/presentation/auth/signup/register.dart';
import 'package:herafy/presentation/auth/signup/register_fill.dart';
import 'package:herafy/presentation/client/client_home.dart';
import 'package:herafy/presentation/home_landing.dart';
import 'package:herafy/presentation/technician/home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/helper/bloc_observer.dart';
import 'domain/cubit/chat/chat_cubit.dart';
import 'presentation/chat/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPreference.initialize();
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => OrderCubit()),
        BlocProvider(create: (context) => ChatCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Herafy',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        locale: const Locale("ar"),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ar'),
        ],
        routes: {
          /**Auth Routes */
          Routes.login: (context) => const LoginPage(),
          Routes.register: (context) => const RegisterationPage(),
          Routes.registerFill: (context) => const RegisterationFillDataPage(),

          /**general Routes */
          Routes.homeLanding: (context) => const HomeLandingPage(),

          /**Admin Routes */
          Routes.adminHome: (context) => const AdminHome(),

          /**Client Routes */
          Routes.clientHome: (context) => const ClientHome(),
          // Routes.chat : (context) =>  ChatScreen(),

          /**Technician Routes */
          Routes.technicianHome: (context) => const TechnicianHomePage(),
        },
        initialRoute: SharedPreference().getString(key: "userID") == null
            ? Routes.login
            : Routes.homeLanding,
      ),
    );
  }
}
