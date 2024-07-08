import 'package:herafy/data/model/order.dart';

sealed class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<Order> orders;
  OrderLoaded({required this.orders});
}

class OrderCreated extends OrderState {}

class OrderDeleted extends OrderState {}

class OrderError extends OrderState {
  final String message;
  OrderError({required this.message});
}
