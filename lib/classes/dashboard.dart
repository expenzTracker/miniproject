import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

final db = FirebaseFirestore.instance;
final user = FirebaseAuth.instance.currentUser;
final uid = user?.uid;
var budgetData;
String? budget;

    
class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      backgroundColor: Colors.black,
      body: Center(
          child: Container(
            width: 300,  
            height: 200,  
            padding: new EdgeInsets.all(10.0),  
            child: Card(
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(30.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                FutureBuilder(
                  future: getAmount(budgetData),
                  builder: (context,snapshot){
                  print("hi");
                  print(budget);
                  return Text("hi");
                  // return Text(data?['amount']);
                }),
                Text("Spent"),
                Text("Left")
              ]),
            ),
          ),
      ),
    );
  }
}

Future getAmount(var budgetData) async {
  final docRef = await db.collection("goals").doc(uid);
  docRef.get().then(
    // (value) => null
    (DocumentSnapshot doc) {
    budgetData = doc.data() as Map<String, dynamic>;
    print(budgetData?['amount']);
    budget=budgetData?['amount'];
    // ...
  },
    onError: (e) => print("Error getting document: $e"),
    );
  
  // return budgetData?['amount'].toString();
}