import 'package:herafy/data/data%20sources/order_remote_data_source.dart';
import 'package:herafy/data/model/order.dart';

class OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepository({required this.remoteDataSource});

  // Future<List<Order>> getAllOrders() async {
  //   try {
  //     return await remoteDataSource.getAllOrders();
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  Future<List<Order>> getAllOrdersBySpeciality(String speciality) async {
    try {
      var orders = await remoteDataSource.getAllOrdersBySpeciality(
          speciality: speciality);
      return orders.map((e) => Order.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
