import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/category_wise.dart';
import 'package:first_app/components/navbar.dart';
import 'package:first_app/uncategorized.dart';
import 'package:flutter/material.dart';
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
    super.initState();
    // fetchSms
    spentData = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    spentData = 0.0;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Dashboard",
            style: TextStyle(color: ColorPalette.piggyPinkDark),
          ),
          backgroundColor: Colors.black,
        ),
        drawer: const DrawerComponent(),
        backgroundColor: Colors.black,
        bottomNavigationBar: const Navbar(),
        body: Column(
          children: [
            FutureBuilder(
                future: getSpentAmount(),
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(31.0)),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  ColorPalette.piggyPinkDark,
                                  Colors.orange
                                ])),
                        width: 300,
                        height: 200,
                        padding: const EdgeInsets.all(3.0),
                        child: Card(
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "This month",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                textBaseline: TextBaseline.alphabetic,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: [
                                  Text("Rs.${(budget - spentData).toString()}",
                                      style: const TextStyle(
                                          fontSize: 24,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  const Text("left",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white))
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
                                          fontSize: 18, color: Colors.white)),
                                  const Text("spent",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
            const Expanded(
              child: SizedBox(
                  height: 400, width: 365, child: UncategorizedSpendsBody()),
            ),
            const CategoryWise(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              AddSpendRoute(builder: (context) => const AddSpend()),
            );
          },
          backgroundColor: ColorPalette.piggyPink,
          // child: Hero(
          //   tag: _heroAddSpend,
          //   child: Material(
          //     color: ColorPalette.piggyPink,
          //     elevation: 2,
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(32)),
          child: const Icon(
            Icons.add_rounded,
            size: 56,
          ),
          //   ),
          // ),
        ));
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
      .where("month", isEqualTo: 'September')
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
