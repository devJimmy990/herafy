import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafy/core/widgets/toast.dart';
import 'package:herafy/data/model/user.dart';
import 'package:herafy/domain/cubit/order/order_cubit.dart';
import 'package:herafy/domain/cubit/order/order_state.dart';
import 'package:herafy/domain/cubit/user/user_cubit.dart';

class AddPost extends StatelessWidget {
  const AddPost({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<OrderCubit>().getOrdersByClientID(
          clientId: context.read<UserCubit>().id,
        );
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<OrderCubit, OrderState>(builder: (context, state) {
            if (state is OrderLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OrderLoaded) {
              return state.orders.isEmpty
                  ? const Center(child: Text("لا يوجد طلبات"))
                  : ListView.builder(
                      itemCount: state.orders.length,
                      itemBuilder: (context, index) {
                        return Text(
                          state.orders[index].description,
                        );
                      });
            } else if (state is OrderError) {
              FailureToast.showToast(msg: state.message.toString());
            }
            return const Text("asddasd");
          }),
        ),
      ),
    );
  }
}
