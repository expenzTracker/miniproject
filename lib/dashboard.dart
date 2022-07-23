import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'classes/color_palette.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
    getAmount();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      backgroundColor: Colors.black,
      body: FutureBuilder(
                  future: getAmount(),
                  builder: (context,snapshot){
                    return Center(
                      child: Container(
                        width: 300,
                        height: 200,
                        padding: new EdgeInsets.all(10.0),  
                        child: Card(
                          color:ColorPalette.piggyGrey,
                          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(30.0)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                textBaseline: TextBaseline.alphabetic,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: [
                                  Text(
                                    "Rs.${budgetData?['monthly_goal']}",
                                    style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)
                                    ),
                                  Text("spent",style: TextStyle(fontSize: 14))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                textBaseline: TextBaseline.alphabetic,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: [
                                  Text(
                                    "Rs.${budgetData?['monthly_goal']}",
                                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)
                                    ),
                                  Text("left",style: TextStyle(fontSize: 10))
                                ],
                              ),
                            
                          ]),
                        )
                      ),
                    );
                  }
      ),
    );
    }}

Future getAmount() async {
  final docRef = await db.collection("goals").doc(uid);
  docRef.get().then(
    (DocumentSnapshot doc) {
    budgetData = doc.data() as Map<String, dynamic>;
    print(budgetData?['monthly_goal']);
    // budget=budgetData?['amount'];
    // ...
  },
    onError: (e) => print("Error getting document: $e"),
    );
  
  return budgetData;
}