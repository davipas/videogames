import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_max),label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.category),label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.gamepad),label: 'Home'),
      ]
    );
  }
}
