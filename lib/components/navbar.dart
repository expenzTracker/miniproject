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
    return
        // Scaffold(
        //   body: Center(
        //     child: _widgetOptions.elementAt(_selectedIndex),
        //   ),
        //   bottomNavigationBar:
        BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_rounded),
          label: 'Dashboard',
          backgroundColor: ColorPalette.piggyGreenDark,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.attach_money_rounded),
          label: 'My expenses',
          backgroundColor: ColorPalette.piggyGreenDark,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on_rounded),
          label: 'Location tracking',
          backgroundColor: ColorPalette.piggyGreenDark,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_rounded),
          label: 'Set goals',
          backgroundColor: ColorPalette.piggyGreenDark,
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: ColorPalette.piggyBlack,
      onTap: _onItemTapped,
    );
    // );
  }
}
