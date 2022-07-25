import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'classes/color_palette.dart';
import 'dashboard.dart';


class UncategorizedSpends extends StatefulWidget {
  const UncategorizedSpends({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _UncategorizedSpendsState();
}


class _UncategorizedSpendsState extends State<UncategorizedSpends> {

  final db = FirebaseFirestore.instance;
  List transactionlist= [];


  

  @override
  Widget build(BuildContext context) {
print(spentData);


    return Scaffold(
      backgroundColor: ColorPalette.piggyBlack,
      appBar: AppBar(
        title: const Text('Uncategorized Spends', style : TextStyle(color: ColorPalette.piggyBlack)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child:FutureBuilder(
            future: getSpentAmount(),
            builder: (context, snapshot){
              return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
                    itemCount: transactionlist.length,
                    padding: const EdgeInsets.only(bottom: 60),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index){ 
                      return Card(
                        child: ListTile(
                          title: Text(transactionlist[index].amount)
                        )
                      );
                     },
            );
            }
          ))
      ),
    );
  }
}