import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafy/core/helper/routes.dart';
import 'package:herafy/core/widgets/appbar_icon.dart';
import 'package:herafy/core/widgets/custom_app_bar.dart';
import 'package:herafy/domain/cubit/auth/auth_cubit.dart';
import 'package:herafy/domain/cubit/auth/auth_state.dart';

class ClientHomePage extends StatelessWidget {
  const ClientHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(
        title: "Client",
        actions: [
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthSignOutSuccess) {
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.login, (route) => false);
              }
            },
            builder: (context, state) {
              return state is AuthLoading
                  ? const CircularProgressIndicator()
                  : appBarIcon(
                      icon: Icons.logout,
                      onTap: () {
                        context.read<AuthCubit>().signOut();
                      },
                    );
            },
          )
        ],
      ),
      body: const Center(child: Text("Client Home Page")),
    );
  }
}
