import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/classes/color_palette.dart';
import 'package:flutter/material.dart';

/// Tag-value used for the add todo popup button.
const String _heroAddSpend = 'add-spend';

String dropdownvalue="-- Select Category --";

 final List<String> categoryitems = <String>[
    "-- Select category --",
    "Food",
    "Travel",
  ];
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

  @override
 void initState() {
    super.initState();
    dropdownvalue=categoryitems[0];

  }

  @override
  Widget build(BuildContext context) {

    final db = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;
    String? category_of_spend;

    
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
                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                        child: Text('New spend',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.white,
                      ),
                      child: const TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'Enter amount',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.white,
                      ),
                      child: DropdownButton(
                        value: dropdownvalue.isNotEmpty? dropdownvalue : '-- Select category --',
                        icon: Icon(Icons.keyboard_arrow_down),  
                        items: categoryitems.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) async {
                          setState(() {
                            dropdownvalue = newValue!;
                            category_of_spend = dropdownvalue;
                          });
                          // final userData = <String, dynamic>{
                          //   "category": data,
                          // };

                          // Add a new document with a generated ID
                          
                          // db
                          //     .collection("users")
                          //     .doc(uid)
                          //     .collection("user_data")
                          //     .add(userData);
                              
                        },
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    ElevatedButton(
                      onPressed: () {},
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