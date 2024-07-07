import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafy/core/widgets/custom_app_bar.dart';
import 'package:herafy/domain/cubit/user/user_cubit.dart';

class ClientHomePage extends StatelessWidget {
  const ClientHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyCustomAppBar(
        title: "Client",
      ),
      body: Column(
        children: [
          const Center(child: Text("Client Home Page")),
          Center(child: Text(context.read<UserCubit>().userType)),
        ],
      ),
    );
  }
}
