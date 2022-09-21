import 'package:first_app/classes/color_palette.dart';
import 'package:first_app/dashboard.dart';
import 'package:first_app/goals/my_goals.dart';
import 'package:first_app/loc_page.dart';
import 'package:first_app/show_sms.dart';
import 'package:first_app/sms_page.dart';
import 'package:flutter/material.dart';

int _selectedIndex = 0;

class Navbar extends StatefulWidget {
  const Navbar({super.key});
  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  static const List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    MyInbox(),
    LocationRoute(),
    MyGoals()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _widgetOptions[_selectedIndex]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.dashboard_rounded,
            color: ColorPalette.piggyCream,
          ),
          label: 'Dashboard',
          backgroundColor: ColorPalette.piggyPinkDark,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.attach_money_rounded,
            color: ColorPalette.piggyCream,
          ),
          label: 'My expenses',
          backgroundColor: ColorPalette.piggyPinkDark,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.location_on_rounded,
            color: ColorPalette.piggyCream,
          ),
          label: 'Location tracking',
          backgroundColor: ColorPalette.piggyPinkDark,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings_rounded,
            color: ColorPalette.piggyCream,
          ),
          label: 'Set goals',
          backgroundColor: ColorPalette.piggyPinkDark,
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: ColorPalette.piggyCream,
      onTap: _onItemTapped,
    );
    // );
  }
}
