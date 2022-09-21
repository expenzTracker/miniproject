import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/choose_bank.dart';
import 'package:first_app/classes/color_palette.dart';
import 'dashboard.dart';
import 'package:first_app/loc_page.dart';
import 'package:first_app/sms_page.dart';
import 'package:first_app/uncategorized.dart';
import 'package:flutter/material.dart';
import './goals/my_goals.dart';
import 'addspend/add_spend.dart';
import 'addspend/add_spend_route.dart';
import 'category_wise.dart';

class DrawerComponent extends StatelessWidget {
  final uid;
  const DrawerComponent({Key? key, this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;

    String? data;
    return Drawer(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: ColorPalette.piggyGreenDark),
              child: const Text('Choose Bank'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChooseBank(uid: uid)),
                );
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: ColorPalette.piggyGreenDark),
              child: const Text('Set goals'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyGoals()),
                );
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: ColorPalette.piggyGreenDark),
              child: const Text('Dashboard'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Dashboard()),
                );
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: ColorPalette.piggyGreenDark),
              child: const Text('Uncategorized spends'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UncategorizedSpends()),
                );
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: ColorPalette.piggyGreenDark),
              child: const Text('Track Location'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LocationRoute()),
                );
              },
            ),
          ]),
    );
  }
}
