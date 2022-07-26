import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/classes/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

final db = FirebaseFirestore.instance;
final user = FirebaseAuth.instance.currentUser;
final uid = user?.uid;

class CategoryWise extends StatefulWidget {
  const CategoryWise({Key? key}) : super(key: key);

  @override
  State<CategoryWise> createState() => _CategoryWiseState();
}

class _CategoryWiseState extends State<CategoryWise> {
  List categorywiseGoals = [];
  List categorywiseExpenditure = [];
  List categorywiseDetails = [[], []];

  getCategorywiseGoals() async {
    await db
        .collection("goals")
        .doc(uid)
        .collection("categories")
        .get()
        .then((value) => {categorywiseGoals = value.docs});
  }

  getCategorywiseExpenditure() async {
    await db
        .collection("goals")
        .doc(uid)
        .collection("categories")
        .get()
        .then((value) => {categorywiseDetails[0] = (value.docs)});
    await db
        .collection("transactions")
        .doc(uid)
        .collection("details")
        .get()
        .then((value) => {categorywiseDetails[1] = (value.docs)});
    return (categorywiseDetails);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPalette.piggyBlack,
        appBar: AppBar(title: const Text("Categorywise")),
        body: FutureBuilder(
          future: getCategorywiseExpenditure(),
          builder: ((context, snapshot) {
            print("***SNAPSHOT**\n${snapshot.data}");
            if (snapshot.hasData) {
              categorywiseGoals = (snapshot.data as List)[0];
              categorywiseExpenditure = (snapshot.data as List)[1];
            }
            return ListView.builder(
                itemCount: categorywiseGoals.length,
                itemBuilder: (context, index) {
                  print("HALO");
                  String currentCategory =
                      (categorywiseGoals[index].data() as Map)['name'];
                  double currentCategoryExpenditure = 0.0;
                  double currentCategoryGoal = 0.0;

                  for (var element in categorywiseGoals) {
                    if ((element.data() as Map)['name'] == currentCategory) {
                      currentCategoryGoal =
                          double.parse((element.data() as Map)['amount']);
                    }
                  }

                  for (var element in categorywiseExpenditure) {
                    if ((element.data() as Map).containsKey('category') &&
                        (element.data() as Map)['category'] ==
                            currentCategory) {
                      print("\n***Amount GOAL***\n${element.data() as Map}");
                      currentCategoryExpenditure +=
                          double.parse((element.data() as Map)['amount']);
                    }
                  }
                  print("\n***CAT GOAL***\n${currentCategoryGoal.toString()}");
                  print(
                      "\n***CAT EXP***\n${currentCategoryExpenditure.toString()}");

                  print("***** ${categorywiseExpenditure[0].data()}");
                  print("##### $categorywiseGoals");
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(27, 8, 27, 8),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 23),
                        child: ListTile(
                          leading: Text(
                              (categorywiseGoals[index].data() as Map)["name"]
                                  .toString()
                                  .toUpperCase()),
                          title: Column(
                            children: [
                              Row(
                                textBaseline: TextBaseline.alphabetic,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: [
                                  Text(
                                    "Rs.${(currentCategoryGoal - currentCategoryExpenditure).toString()}",
                                    style: const TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    "  left",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              Row(
                                textBaseline: TextBaseline.alphabetic,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: [
                                  Text(
                                    "Rs.${currentCategoryExpenditure.toString()}",
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                  const Text(
                                    "  spent",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }),
        ));
  }
}
