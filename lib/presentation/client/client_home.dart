import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:herafy/presentation/client/post/add_post_bottom_sheet.dart';
import 'package:herafy/presentation/client/profile/client_profile.dart';
import 'package:herafy/presentation/client/post/post.dart';
import 'package:herafy/presentation/client/search/search.dart';

class ClientHome extends StatefulWidget {
  const ClientHome({super.key});

  @override
  State<ClientHome> createState() => _ClientHomeState();
}

class _ClientHomeState extends State<ClientHome> {
  int index = 0;

  final List<Widget> _screens = [
    const AddPost(),
    const ClientProfile(),
    const SearchScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[index],
      floatingActionButton: index == 1
          ? null
          : FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const AddPostBottomSheet(),
                );
              },
              backgroundColor: Colors.blue,
              child: const Icon(
                Icons.add,
                size: 28,
                color: Colors.white,
              ),
            ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
              icon: Icons.person,
              text: 'الملف الشخصي',
            ),
          ],
        ),
      ),
    );
  }
}
