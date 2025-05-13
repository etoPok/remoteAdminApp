import 'package:flutter/material.dart';

import 'like.dart';
import 'profile.dart';
import 'splash.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Index 0: Home', style: optionStyle),
    Text('Index 1: Business', style: optionStyle),
    Text('Index 2: School', style: optionStyle),
  ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),

      body: Center(child: _widgetOptions[_selectedIndex]),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Profile'),
              selected: _selectedIndex == 0,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile()));
              },
            ),
            ListTile(
              title: const Text('Like'),
              selected: _selectedIndex == 1,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Like()));
              },
            ),
            ListTile(
              title: const Text('Splash'),
              selected: _selectedIndex == 2,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Splash()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
