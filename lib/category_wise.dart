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
  List categorywiseDetails = [
    [],
    []
  ]; //[categorywiseGoals][ategorywiseExpenditure]

  getCategorywiseGoals() async {
    await db
        .collection("goals")
        .doc(uid)
        .collection("categories")
        .get()
        .then((value) => {categorywiseGoals = value.docs});
  }

  getCategorywiseExpenditure() async {
    await db.collection("goals").doc(uid).collection("categories").get().then(
        (value) => {
              categorywiseDetails[0] = (value.docs)
            }); //athayath categorywisegoals
    await db
        .collection("transactions")
        .doc(uid)
        .collection("details")
        .get()
        .then((value) => {
              categorywiseDetails[1] = (value.docs)
            }); //athayath categorywiseexpenditure
    return (categorywiseDetails);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCategorywiseExpenditure(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          categorywiseGoals = (snapshot.data as List)[0];
          categorywiseExpenditure = (snapshot.data as List)[1];
        }
        return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: categorywiseGoals.length,
            itemBuilder: (context, index) {
              String currentCategory =
                  (categorywiseGoals[index].data() as Map)['name'];
              double currentCategoryExpenditure = 0.0;
              double currentCategoryGoal = 0.0;

              for (var element in categorywiseGoals) {
                //searching
                if ((element.data() as Map)['name'] == currentCategory) {
                  currentCategoryGoal =
                      double.parse((element.data() as Map)['amount']);
                }
              }

              for (var element in categorywiseExpenditure) {
                //searching
                if ((element.data() as Map).containsKey('category') &&
                    (element.data() as Map)['category'] == currentCategory) {
                  currentCategoryExpenditure +=
                      double.parse((element.data() as Map)['amount']);
                }
              }

              return Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: const BorderSide(
                      color: ColorPalette.piggyPinkDark, //<-- SEE HERE
                    ),
                  ),
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 23),
                    child: ListTile(
                      leading: Text(
                        (categorywiseGoals[index].data() as Map)["name"]
                            .toString()
                            .toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            textBaseline: TextBaseline.alphabetic,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Text(
                                "Rs.${(currentCategoryGoal - currentCategoryExpenditure).toString()}",
                                style: const TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const Text(
                                "  left",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            textBaseline: TextBaseline.alphabetic,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Text(
                                "Rs.${currentCategoryExpenditure.toString()}",
                                style: const TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                              const Text(
                                "  spent",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
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
    );
  }
}
