import 'package:flutter/material.dart';
import 'package:herafy/data/model/order.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafy/core/widgets/toast.dart';
import 'package:herafy/domain/cubit/user/user_cubit.dart';
import 'package:herafy/domain/cubit/order/order_cubit.dart';
import 'package:herafy/domain/cubit/order/order_state.dart';
import 'package:herafy/presentation/technician/order/order_widget.dart';

class BrowseProposaledPage extends StatelessWidget {
  const BrowseProposaledPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String technician = context.read<UserCubit>().id;
    context.read<OrderCubit>().getAllOrdersBySpeciality(
        speciality: context.read<UserCubit>().speciality);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 16.0), //const EdgeInsets.all(16.0),
          child: BlocBuilder<OrderCubit, OrderState>(builder: (context, state) {
            if (state is OrderLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OrderLoaded) {
              if (state.orders.isEmpty) {
                return const Center(child: Text("لا يوجد طلبات"));
              } else {
                // SuccessToast.showToast(msg: "state.message.toString()");
                final List<Order> orders = state.orders
                    .where((order) => order.proposals
                        .every((proposal) => proposal.id == technician))
                    .toList();
                return ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      return OrderCard(
                        isView: true,
                        order: orders[index],
                      );
                    });
              }
            } else if (state is OrderError) {
              FailureToast.showToast(msg: state.message.toString());
            }
            return const SizedBox();
          }),
        ),
      ),
    );
  }
}
