import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/classes/color_palette.dart';
import 'package:first_app/dashboard.dart';
import 'package:flutter/material.dart';

import 'components/navbar.dart';
import 'drawer_component.dart';

String dropdownvalue = 'State Bank of India';

// List of items in our dropdown menu
var items = [
  'State Bank of India',
  'City Union Bank',
  'HDFC Bank',
  'Axis Bank',
  'ICICI Bank',
  'Canara Bank',
  'Bank of Baroda',
  'South Indian Bank',
  'UCO Bank',
  'Dhanalaxmi Bank'
];

class ChooseBank extends StatefulWidget {
  final uid;
  const ChooseBank({Key? key, this.uid}) : super(key: key);

  @override
  State<ChooseBank> createState() => _ChooseBankState();
}

class _ChooseBankState extends State<ChooseBank> {
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;
    String? data;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Choose Bank',
          style: TextStyle(color: ColorPalette.piggyPinkDark),
        ),
        backgroundColor: Colors.black,
      ),
      drawer: const DrawerComponent(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Choose your bank",
              style: TextStyle(color: ColorPalette.piggyBlueDark, fontSize: 23),
            ),
            const SizedBox(height: 10),
            DropdownButton(
              value: dropdownvalue,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) async {
                setState(() {
                  dropdownvalue = newValue!;
                  data = dropdownvalue;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Dashboard()),
                  );
                });
                final userData = <String, dynamic>{
                  "bank": data,
                };
                // Add a new document with a generated ID
                db.collection("banks").doc(uid).set(userData);
              },
            )
          ],
        ),
      ),
    );
  }
}
