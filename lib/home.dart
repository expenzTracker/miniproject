import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/choose_bank.dart';
import 'package:first_app/classes/color_palette.dart';
import 'package:first_app/classes/dashboard.dart';
import 'package:first_app/loc_page.dart';
import 'package:first_app/sms_page.dart';
import 'package:flutter/material.dart';
import 'package:first_app/goals/my_goals.dart';
import 'package:first_app/addspend/add_spend.dart';
import 'package:first_app/addspend/add_spend_route.dart';



const String _heroAddSpend = 'add-spend';


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

      body: SingleChildScrollView(
        child: Center(
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
                  final userData = <String, dynamic>{
                    "first": data,
                    "last": "Lovelace",
                    "born": 1815,
                    "character": "happy"
                  };
                  // Add a new document with a generated ID
                  db
                      .collection("users")
                      .doc(uid)
                      .collection("user_data")
                      .add(userData);
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
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                    context,
                    AddSpendRoute(builder: (context) => const AddSpend()),
                  );
                  },
                  child: Hero(
                    tag: _heroAddSpend,
                    child: Material(
                      color: ColorPalette.piggyPink,
                      elevation: 2,
                      shape:
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                      child: const Icon(
                        Icons.add_rounded,
                        size: 56,
                      ),
                    ),
                  ),
                ),
              )      
            ],
          ),

        ),
      ),
    );
  }
}
