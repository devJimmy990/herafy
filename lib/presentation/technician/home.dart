import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:herafy/presentation/technician/order/order.dart';
import 'package:herafy/presentation/technician/profile/profile.dart';
import 'package:herafy/presentation/technician/order/proposaled_order.dart';

class TechnicianHomePage extends StatefulWidget {
  const TechnicianHomePage({super.key});

  @override
  State<TechnicianHomePage> createState() => _TechnicianHomePageState();
}

class _TechnicianHomePageState extends State<TechnicianHomePage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const AvailableJobsPage(),
      const BrowseProposaledPage(),
      const ProfilePage(),
      const Center(
          child: Text(
              'Settings Screen')), // This should be a different screen if intended
    ];
    return Scaffold(
      body: SafeArea(child: screens[index]
          // BlocProvider<TechnicainPaginationCubit>(
          //   create: (_) => TechnicainPaginationCubit(),
          //   child:
          //       BlocBuilder<TechnicainPaginationCubit, TechnicianPaginationState>(
          //     builder: (context, state) {
          //       if (state is TechnicianPaginationInitial ||
          //           state is TechnicianPaginationChangeIndex) {
          //         return screens[state.index];
          //       }
          //       return Container();
          //     },
          //   ),
          // ),
          ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: GNav(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          gap: 10,
          iconSize: 28,
          color: Colors.white,
          activeColor: Colors.white,
          backgroundColor: Colors.black,
          curve: Curves.easeInOut,
          onTabChange: (value) => setState(() => index = value),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'الرئيسية',
            ),
            GButton(
              icon: Icons.construction,
              text: 'العروض',
            ),
            GButton(
              icon: Icons.person,
              text: 'الملف الشخصي',
            ),
          ],
        ),
      ),
    );
  }
}
