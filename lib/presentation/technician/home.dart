import 'package:flutter/material.dart';
import 'package:herafy/core/widgets/custom_app_bar.dart';

class TechnicianHomePage extends StatelessWidget {
  const TechnicianHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyCustomAppBar(
        title: "Technician",
      ),
      body: Center(child: Text("Technician Home Page")),
    );
  }
}
