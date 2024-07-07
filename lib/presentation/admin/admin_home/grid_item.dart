import 'package:flutter/material.dart';

Widget gridItem(model) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Column(
        children: [
          Expanded(
            child: Image(
              image: AssetImage(
                model.image,
              ),
              height: 150,
              width: 150,
            ),
          ),
          Text(
            model.body,
          ),
          const SizedBox(height: 30),
        ],
      ),
    ),
  );
}
