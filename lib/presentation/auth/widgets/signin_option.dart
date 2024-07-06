import 'package:flutter/material.dart';
import 'package:herafy/presentation/auth/widgets/auth_options.dart';

Widget signInOptions() {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: 25),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: [
            Expanded(
                child: Divider(
              height: 4,
              thickness: 2,
            )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "Or sign in with",
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
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: ExternalSignOptions(),
        ),
      ],
    ),
  );
}
