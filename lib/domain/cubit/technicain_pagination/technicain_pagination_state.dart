import 'package:flutter/material.dart';

sealed class TechnicianPaginationState {
  final int  index;
  TechnicianPaginationState(this.index);
}

class TechnicianPaginationInitial extends TechnicianPaginationState {
  TechnicianPaginationInitial(super.index);
}

class TechnicianPaginationChangeIndex extends TechnicianPaginationState {
  TechnicianPaginationChangeIndex(super.index);
}
