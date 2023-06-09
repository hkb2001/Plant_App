import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/screens/details/components/user.dart';
import 'package:plant_app/screens/home/home_screen.dart';

import '../screens/details/components/heart.dart';
import '../screens/details/components/upload.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({Key? key}) : super(key: key);

  @override
  _MyBottomNavBarState createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    // Add your screens here
    const HomeScreen(),
    const HeartScreen(),
    const UserScreen(),
    const upload(),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      selectedItemColor: kPrimaryColor,
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
        });
        // Navigate to the selected screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => _screens[index]),
        );
      },
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset("assets/icons/flower.svg"),
          label: 'Flower',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset("assets/icons/heart-icon.svg"),
          label: 'Heart',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset("assets/icons/user-icon.svg"),
          label: 'User',
        ),
        const BottomNavigationBarItem(icon: Icon(Icons.upload), label: 'Upload')
      ],
    );
  }
}
