import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

import '../classes/color_palette.dart';

final db = FirebaseFirestore.instance;
final user = FirebaseAuth.instance.currentUser;
final uid = user?.uid;
String? category_of_spend = "-- Select category --";
String? catAdded = "";

class AddCategory extends StatefulWidget {
  final String tsId;
  const AddCategory({super.key, required this.tsId});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

List<String> items = ["-- Select category --"];
getCategorywiseGoals() async {
  List temp = [];
  await db
      .collection("goals")
      .doc(uid)
      .collection("categories")
      .get()
      .then((value) => {temp = value.docs});
  for (var item in temp) {
    items.add(item.id.toString());
  }
  items = items.toSet().toList();
  return temp;
}

class _AddCategoryState extends State<AddCategory> {
  get amount => null;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: "Add Category",
          child: Material(
            color: ColorPalette.piggyViolet,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                      child: Text(
                        'New spend',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Container(
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.white,
                      ),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: FutureBuilder(
                              future: getCategorywiseGoals(),
                              builder: (context, snapshot) {
                                return DropdownButton(
                                  value: category_of_spend,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: items.map((item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      category_of_spend = newValue;
                                      catAdded = category_of_spend;
                                    });
                                  },
                                );
                              })),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        db
                            .collection("transactions")
                            .doc(uid)
                            .collection("details")
                            .doc(widget.tsId)
                            .set({"category": catAdded},
                                SetOptions(merge: true));
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
