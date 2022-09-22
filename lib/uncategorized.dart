import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/addspend/add_category.dart';
import 'package:flutter/material.dart';
import 'addspend/add_spend_route.dart';
import 'classes/color_palette.dart';
import 'dashboard.dart';
import 'drawer_component.dart';

final db = FirebaseFirestore.instance;
final transactionlist = [];

getSpentDetails() async {
  getAmount();
  int count = 0;
  await db.collection("transactions").doc(uid).collection('details').get().then(
      (QuerySnapshot doc) {
    spentDataDoc = doc.docs;

    spentDataDoc.forEach((value) => {
          if (!value.data().containsKey('category'))
            {
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
      onError: (e) => print("Error getting document: $e"));
  return spentDataDoc;
}

class UncategorizedSpendsBody extends StatefulWidget {
  const UncategorizedSpendsBody({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _UncategorizedSpendsBodyState();
}

class _UncategorizedSpendsBodyState extends State<UncategorizedSpendsBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(30),
            child: FutureBuilder(
                future: getSpentDetails(),
                builder: (context, snapshot) {
                  // transactionlist.sort((a, b) {
                  //   return a['date'].compareTo(b['date']);
                  // });
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: transactionlist.length,
                    padding: const EdgeInsets.only(bottom: 60),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      index = transactionlist.length - 1 - index;
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            AddSpendRoute(
                                builder: (context) => const AddCategory()),
                          );
                        },
                        child: Card(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: const BorderSide(
                                color: Colors.orange,
                              ),
                            ),
                            child: ListTile(
                              title: Text(
                                  transactionlist[index]['amount'].toString(),
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              subtitle: Row(
                                children: [
                                  Text(
                                    transactionlist[index]['time']
                                        .toString()
                                        .split('.')[0],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    transactionlist[index]['date'].toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              trailing: const Icon(
                                Icons.turned_in_not,
                                color: Colors.white,
                              ),
                            )),
                      );
                    },
                  );
                })));
  }
}

class UncategorizedSpends extends StatefulWidget {
  const UncategorizedSpends({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _UncategorizedSpendsState();
}

class _UncategorizedSpendsState extends State<UncategorizedSpends> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Uncategorized Spends',
            style: TextStyle(color: Colors.white)),
      ),
      drawer: const DrawerComponent(),
      body: const UncategorizedSpendsBody(),
    );
  }
}
