import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafy/data/data%20sources/order_remote_data_source.dart';
import 'package:herafy/data/model/order.dart';
import 'package:herafy/data/repositories/order_repository.dart';
import 'package:herafy/domain/cubit/order/order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());
  // getAllOrders()async {
  //   emit(OrderLoading());
  //   try {
  //     List<Order> orders = await OrderRepository(
  //             remoteDataSource: OrderRemoteDataSource());
  //         .getAllOrders();
  //     )
  //     emit(OrderLoaded(orders: []));
  //   } catch (e) {
  //     emit(OrderError(message: e.toString()));
  //   }
  // }

  void getAllOrdersBySpeciality({required String speciality}) async {
    emit(OrderLoading());
    try {
      List<Order> orders =
          await OrderRepository(remoteDataSource: OrderRemoteDataSource())
              .getAllOrdersBySpeciality(speciality);

      orders.sort((a, b) => a.postedDate!.compareTo(b.postedDate!));

      emit(OrderLoaded(orders: orders.isEmpty ? [] : orders));
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }
}
