import 'package:flutter/material.dart';

Widget signInOptions() {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: 25),
    child: Row(
      children: [
        Expanded(
            child: Divider(
          height: 4,
          thickness: 2,
        )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            "او التسجيل بواسطة",
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
        ),
        Expanded(
            child: Divider(
          height: 4,
          thickness: 2,
        )),
      ],
    ),
  );
}
