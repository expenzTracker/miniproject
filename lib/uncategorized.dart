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
  final transactionlist= [];


  getSpentDetails() async {
      getAmount();
      int count=0;
  await db.collection("transactions").doc(uid).collection('details').get().then(
    (QuerySnapshot doc) {
      spentDataDoc = doc.docs;
      
      spentDataDoc.forEach((value)=>{
        if(!value.data().containsKey('category')){
          transactionlist.add({
          'amount': value.data()['amount'],
          'date': value.data()['date'],
          'month': value.data()['month'],
          'time': value.data()['time'],
        })
        }
        
        });
    },
        // )+=(double.parse((value.data() as Map)['amount']))
               onError: (e) => print("Error getting document: $e")
      );

  return spentDataDoc;
  }
   

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorPalette.piggyBlack,
      appBar: AppBar(
        title: const Text('Uncategorized Spends', style : TextStyle(color: ColorPalette.piggyBlack)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child:FutureBuilder(
            future: getSpentDetails(),
            builder: (context, snapshot){



              print('#############################');
              print(transactionlist);

              
              return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
                    itemCount: transactionlist.length,
                    padding: const EdgeInsets.only(bottom: 60),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index){ 
                      return Card(
                        child: ListTile(
                          title: Text(transactionlist[index]['amount'].toString(),style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                          subtitle: Row(
                            children: [
                              Text(transactionlist[index]['time'].toString().split('.')[0],),  
                              const SizedBox(width: 10),                           
                              Text(transactionlist[index]['date'].toString()),
                            ],
                          ),
                          trailing: const Icon(Icons.turned_in_not),

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