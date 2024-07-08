import 'package:flutter/material.dart';
import 'package:herafy/presentation/client/profile/client_profile.dart';
import 'package:herafy/presentation/client/post/add_post.dart';
import 'package:herafy/presentation/client/search/search.dart';

class ClientHome extends StatefulWidget {
  const ClientHome({super.key});

  @override
  State<ClientHome> createState() => _ClientHomeState();
}

class _ClientHomeState extends State<ClientHome> {
  int currentIndex = 1;

  final List<Widget> screens = [
    const ClientProfile(),
    const SearchScreen(),
    const AddPost(),
  ];

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onTabTapped(2);
        },
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        height: 60,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                onTabTapped(0);
              },
            ),
            const SizedBox(width: 40), // Space for the floating button
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                onTabTapped(1);
              },
            ),
          ],
        ),
      ),
    );
  }
}
