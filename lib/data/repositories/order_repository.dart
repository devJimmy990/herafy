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
      return orders
          .map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  getAllOrders() async {
    try {
      var orders = await remoteDataSource.getAllOrders();
      return orders
          .map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Order> addNewOrder(Order order) async {
    try {
      return await remoteDataSource.addNewOrder(order);
    } catch (e) {
      throw Exception(e);
    }
  }

  getOrdersByClientID(String clientId) async {
    try {
      var orders =
          await remoteDataSource.getOrdersByClientID(clientId: clientId);
      return orders
          .map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  addProposal({required String order,required String technician}) async {
    try {
      return await remoteDataSource.addProposal(
        order, technician,
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
