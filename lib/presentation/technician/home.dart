import 'package:flutter/material.dart';
import 'package:herafy/core/widgets/appbar_icon.dart';
import 'package:herafy/core/widgets/custom_app_bar.dart';

class TechnicianHomePage extends StatelessWidget {
  const TechnicianHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(
        title: "Technician",
        actions: [appBarIcon(icon: Icons.logout, onTap: () {})],
      ),
      body: const Center(child: Text("Technician Home Page")),
    );
  }
}
