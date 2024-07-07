import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GeneralToast {
  static void showToast({
    required String msg,
    bool isLong = false,
    double fontSize = 16,
    Color? bgColor = Colors.black,
    Color? textColor = Colors.white,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      fontSize: fontSize,
      textColor: textColor,
      timeInSecForIosWeb: 1,
      backgroundColor: bgColor,
      gravity: ToastGravity.BOTTOM,
      toastLength: isLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
    );
  }
}

class FailureToast {
  static void showToast({
    required String msg,
    bool isLong = false,
    double fontSize = 16,
    Toast? length = Toast.LENGTH_SHORT,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      fontSize: fontSize,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      toastLength: isLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
    );
  }
}

class SuccessToast {
  static void showToast({
    required String msg,
    bool isLong = false,
    double fontSize = 16,
    Toast? length = Toast.LENGTH_SHORT,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      fontSize: fontSize,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      toastLength: isLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
    );
  }
}
