import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafy/core/helper/routes.dart';
import 'package:herafy/core/widgets/toast.dart';
import 'package:herafy/domain/cubit/user/user_cubit.dart';
import 'package:herafy/domain/cubit/user/user_state.dart';

class HomeLandingPage extends StatelessWidget {
  const HomeLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserCubit>().loadUserData();
    return Scaffold(
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              context.read<UserCubit>().isClient
                  ? Routes.clientHome
                  : Routes.technicianHome,
              (route) => false,
            );
            // return const Center(child: Text("User Data Loaded"));
          } else if (state is UserError) {
            FailureToast.showToast(msg: state.message);
          }
          return Container();
        },
      ),
    );
  }
}
