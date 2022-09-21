import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/classes/color_palette.dart';
import 'package:flutter/material.dart';

/// Tag-value used for the add todo popup button.
const String _heroAddSpend = 'add-spend';
final db = FirebaseFirestore.instance;
final user = FirebaseAuth.instance.currentUser;
final uid = user?.uid;

String? category_of_spend = items[0];

final List<String> items = <String>[
  "-- Select category --",
  "Food",
  "Travel",
];

var spendData = <String, dynamic>{
  "amount": "0",
  "category": "-- Select category --",
  "date": DateTime.now().day.toString(),
};

/// [HeroDialogRoute] to achieve the popup effect.
///
/// Uses a [Hero] with tag [_heroAddSpend].
/// {@endtemplate}
class AddSpend extends StatefulWidget {
  final uid;
  const AddSpend({Key? key, this.uid}) : super(key: key);

  @override
  State<AddSpend> createState() => _AddSpendState();
}

class _AddSpendState extends State<AddSpend> {
  String amount = '';
  // final amountController = TextEditingController();

//  @override
//   void initState() {
//     super.initState();
//     amountController.addListener(_handleamountChange);
//     category_of_spend=items[0];
//   }

  // void _handleamountChange() {
  //   setState(() {
  //     amount = amountController.text;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroAddSpend,
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
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                            onChanged: (value) {
                              amount = value;
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Enter spend amount',
                            )),
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    Container(
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: DropdownButton(
                          value: category_of_spend,
                          icon: Icon(Icons.keyboard_arrow_down),
                          items: items.map((String item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              category_of_spend = newValue!;
                              spendData["spendAount"] = amount;
                              spendData["category"] = category_of_spend;
                            });
                          },
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        //print(amount);
                        //print(category_of_spend);
                        db
                            .collection("users")
                            .doc(uid)
                            .collection("transactions")
                            .add(spendData);
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
