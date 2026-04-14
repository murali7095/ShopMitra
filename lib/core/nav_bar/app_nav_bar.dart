import 'package:flutter/material.dart';

class FloatingNavBarExample extends StatefulWidget {
  const FloatingNavBarExample({super.key});

  @override
  _FloatingNavBarExampleState createState() => _FloatingNavBarExampleState();
}

class _FloatingNavBarExampleState extends State<FloatingNavBarExample> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text("Home")),
    Center(child: Text("Search")),
    Center(child: Text("Cart")),
    Center(child: Text("Profile")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],

      backgroundColor: Colors.grey[100],

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0), // 👈 makes it float
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30), // 👈 rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            backgroundColor: Colors.transparent, // 👈 important
            elevation: 0, // 👈 remove default shadow
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
            ],
          ),
        ),
      ),
    );
  }
}