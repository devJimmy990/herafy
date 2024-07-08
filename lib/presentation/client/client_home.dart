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
  int _currentIndex = 1;

  final List<Widget> _screens = [
    const ClientProfile(),
    const SearchScreen(),
    const AddPost(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onTabTapped(1);
        },
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        child: const Icon(Icons.home),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                _onTabTapped(0);
              },
            ),
            const SizedBox(width: 40), // Space for the floating button
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                _onTabTapped(2);
              },
            ),
          ],
        ),
      ),
    );
  }
}
