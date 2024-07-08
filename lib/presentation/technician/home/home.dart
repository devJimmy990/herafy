import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafy/core/widgets/custom_app_bar.dart';
import 'package:herafy/domain/cubit/order/order_cubit.dart';

class TechnicianHomePage extends StatelessWidget {
  const TechnicianHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyCustomAppBar(
        title: "Technician",
      ),
      body: Column(
        children: [
          Center(child: Text("Technician Home Page")),
          // FutureBuilder(future: future, builder: (builder, snapshot) {
          //   return Text(context.read<OrderCubit>().);
          // })
        ],
      ),
    );
  }
}
