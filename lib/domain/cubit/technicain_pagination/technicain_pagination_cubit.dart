import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafy/domain/cubit/technicain_pagination/technicain_pagination_state.dart';
import 'package:herafy/presentation/technician/order/order.dart';
import 'package:herafy/presentation/technician/profile/profile.dart';

class TechnicainPaginationCubit extends Cubit<TechnicianPaginationState> {
  TechnicainPaginationCubit() : super(TechnicianPaginationInitial(0));

  void changeIndex(int index) {
    // print("index $index");
    emit(TechnicianPaginationChangeIndex(index));
  }
}
