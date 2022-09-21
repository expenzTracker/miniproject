import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/category_wise.dart';
import 'package:first_app/uncategorized.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'addspend/add_spend.dart';
import 'addspend/add_spend_route.dart';
import 'classes/color_palette.dart';
import 'drawer_component.dart';

final db = FirebaseFirestore.instance;
final user = FirebaseAuth.instance.currentUser;
final uid = user?.uid;
var budgetData;
var spentData = 0.0;
var spentDataDoc;
double budget = 0.0;
const String _heroAddSpend = 'add-spend';

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
    spentData = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    spentData = 0.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: ColorPalette.piggyViolet,
      ),
      drawer: const DrawerComponent(),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          FutureBuilder(
              future: getSpentAmount(),
              builder: (context, snapshot) {
                return Column(
                  children: [
                    Container(
                        width: 300,
                        height: 200,
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          color: ColorPalette.piggyGrey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                textBaseline: TextBaseline.alphabetic,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: [
                                  Text("Rs.${(budget - spentData).toString()}",
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold)),
                                  const Text("left",
                                      style: TextStyle(fontSize: 10))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                textBaseline: TextBaseline.alphabetic,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: [
                                  Text("Rs.${spentData.toString()}",
                                      style: const TextStyle(
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold)),
                                  const Text("spent",
                                      style: TextStyle(fontSize: 14))
                                ],
                              ),
                            ],
                          ),
                        )),
                    // CategoryWise(),
                  ],
                );
              }),
          const Expanded(child: SizedBox(height: 300, child: CategoryWise())),
          const SizedBox(
              height: 200, width: 365, child: UncategorizedSpendsBody()),
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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)),
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
    );
  }
}

getAmount() async {
  await db.collection("goals").doc(uid).get().then(
    (DocumentSnapshot doc) {
      budgetData = doc.data() as Map<String, dynamic>;
    },
    onError: (e) => print("Error getting document: $e"),
  );
  budget = double.parse(budgetData?['monthly_goal']);
  // return budget;
}

getSpentAmount() async {
  getAmount();
  await db
      .collection("transactions")
      .doc(uid)
      .collection('details')
      .where("month", isEqualTo: 'July')
      .get()
      .then(
    (QuerySnapshot doc) {
      spentDataDoc = doc.docs;
      spentDataDoc.forEach((value) =>
          {spentData += (double.parse((value.data() as Map)['amount']))});
      return spentData;
    },
    onError: (e) => print("Error getting document: $e"),
  );

  return spentData;
}
