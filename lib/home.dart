
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/choose_bank.dart';
import 'package:first_app/classes/color_palette.dart';
import 'dashboard.dart';
import 'package:first_app/loc_page.dart';
import 'package:first_app/sms_page.dart';
import 'package:first_app/uncategorized.dart';
import 'package:flutter/material.dart';
import './goals/my_goals.dart';
import 'addspend/add_spend.dart';
import 'addspend/add_spend_route.dart';



const String _heroAddSpend = 'add-spend';


class Home extends StatelessWidget {
  final uid;
  const Home({Key? key, this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    final db = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;

    final CollectionReference transactionlist=FirebaseFirestore.instance.collection('transactions').doc().collection('details');

    Future <void> createTransactionData(
      String amount, String category, String date, String month, String time) async {
        return await transactionlist.doc(uid).set({"amount": amount,"category":category });
     }

     Future getTransactionList() async {
      try{
        await transactionlist.get().then((value) => QueryDocumentSnapshot);
      } catch(e){
      }
     }
    
    
    String? data;
    return Scaffold(
      backgroundColor: ColorPalette.piggyBlack,
      appBar: AppBar(
        title: const Text('Home'),
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('Location Track route'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LocationRoute()),
                  );
                },
              ),
              ElevatedButton(
                child: const Text('Choose Bank'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChooseBank(uid : uid)),
                  );
                },
              ),
              ElevatedButton(
                child: const Text('Set goals'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyGoals()),
                  );
                },
              ),
              ElevatedButton(
                child: const Text('Dashboard'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Dashboard()),
                  );
                },
              ),
              ElevatedButton(
                child: const Text('Uncategorized spends'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UncategorizedSpends()),
                  );
                },
              ),
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
                      shape:
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
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

        ),
      ),
    );
  }
}
