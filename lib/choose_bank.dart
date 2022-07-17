import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: const Text('Choose Bank'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                });
                final userData = <String, dynamic>{
                  "bank": data,
                };
                // Add a new document with a generated ID
                db
                    .collection("users")
                    .doc(uid)
                    .collection("user_data")
                    .add(userData);
                    
              },
              )
            
          ],
        ),
      ),
    );
    
  }
}
