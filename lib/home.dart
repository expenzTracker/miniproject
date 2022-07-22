import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/choose_bank.dart';
import 'package:first_app/classes/dashboard.dart';
import 'package:first_app/loc_page.dart';
import 'package:first_app/sms_page.dart';
import 'package:flutter/material.dart';
import 'package:first_app/my_goals.dart';

class Home extends StatelessWidget {
  final uid;
  const Home({Key? key, this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;
    String? data;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Sms Route'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyInbox()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Location Track route'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LocationRoute()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Choose Bank'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChooseBank(uid : uid)),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Set goals'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyGoals()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Dashboard'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Dashboard()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
