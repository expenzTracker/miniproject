import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/choose_bank.dart';
import 'package:first_app/loc_page.dart';
import 'package:first_app/sms_page.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    String? data;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
              ),
              padding: const EdgeInsets.only(left: 40, right: 20),
              margin: const EdgeInsets.only(top: 10),
              width: 350,
              child: TextFormField(
                onChanged: (value) {
                  data = value;
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Enter your data',
                ),
              ),
            ),
            ElevatedButton(
              child: const Text('Send'),
              onPressed: () async {
                // Create a new user with a first and last name
                final user = <String, dynamic>{
                  "first": data,
                  "last": "Lovelace",
                  "born": 1815
                };
                // Add a new document with a generated ID
                db.collection("users").add(user).then((DocumentReference doc) =>
                    print('DocumentSnapshot added with ID: ${doc.id}'));
              },
            ),
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
                  MaterialPageRoute(builder: (context) => const ChooseBank()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
