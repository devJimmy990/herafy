import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafy/data/data%20sources/order_remote_data_source.dart';
import 'package:herafy/data/model/order.dart';
import 'package:herafy/data/model/technician.dart';
import 'package:herafy/data/repositories/order_repository.dart';
import 'package:herafy/domain/cubit/order/order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  List<Order> orders = [];

  void addProposal(
      {required String orderID, required Technician technician}) async {
    try {
      emit(OrderLoading());
      await OrderRepository(
        remoteDataSource: OrderRemoteDataSource(),
      ).addProposal(order: orderID, technician: technician.id!);
      orders.firstWhere((element) => element.id == orderID).proposals = [
        ...orders.firstWhere((element) => element.id == orderID).proposals,
        technician
      ];
      emit(OrderLoaded(orders: orders));
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }

  void addNewOrder({required Order order}) async {
    emit(OrderLoading());
    try {
      order = await OrderRepository(
        remoteDataSource: OrderRemoteDataSource(),
      ).addNewOrder(order);
      emit(OrderLoaded(orders: [...orders, order]));
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }

  void getAllOrders() async {
    emit(OrderLoading());
    try {
      if (orders.isNotEmpty) {
        emit(OrderLoaded(orders: orders));
        return;
      }
      orders = await OrderRepository(
        remoteDataSource: OrderRemoteDataSource(),
      ).getAllOrders();

      emit(OrderLoaded(orders: orders));
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }

  void getOrdersByClientID({required String clientId}) async {
    emit(OrderLoading());
    try {
      if (orders.isNotEmpty) {
        emit(OrderLoaded(orders: orders));
        return;
      }
      orders = await OrderRepository(
        remoteDataSource: OrderRemoteDataSource(),
      ).getOrdersByClientID(clientId);

      emit(OrderLoaded(orders: orders));
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }

  void getAllOrdersBySpeciality({required String speciality}) async {
    emit(OrderLoading());
    try {
      if (orders.isNotEmpty) {
        emit(OrderLoaded(orders: orders));
        return;
      }
      orders = await OrderRepository(
        remoteDataSource: OrderRemoteDataSource(),
      ).getAllOrdersBySpeciality(speciality);
      print("Error - Track: Cubit Success $orders");

      orders.sort((a, b) => b.postedDate!.compareTo(a.postedDate!));
      emit(OrderLoaded(orders: orders.isEmpty ? [] : orders));
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }
}
