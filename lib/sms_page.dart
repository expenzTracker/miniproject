import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sms_advanced/sms_advanced.dart';

final db = FirebaseFirestore.instance;
final user = FirebaseAuth.instance.currentUser;
final uid = user?.uid;

class MyInbox extends StatefulWidget {
  const MyInbox({Key? key}) : super(key: key);

  @override
  State createState() {
    return MyInboxState();
  }
}

class MyInboxState extends State {
  // SmsReceiver receiver = new SmsReceiver();
  SmsQuery query = SmsQuery();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List messages = [];
    Map months = {
      '01': 'January',
      '02': 'February',
      '03': 'March',
      '04': 'April',
      '05': 'May',
      '06': 'June',
      '07': 'July',
      '08': 'August',
      '09': 'September',
      '10': 'October',
      '11': 'November',
      '12': 'December',
    };
    List allMessages = [];

    return Scaffold(
        // backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("Monthly Expenditure"),
          backgroundColor: Colors.pink,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              fetchSMS(messages, months, allMessages);
            });
          },
          child: FutureBuilder(
            future: fetchSMS(messages, months, allMessages),
            builder: (context, snapshot) {
              // return Text(
              //   data.toString()
              // );
              return ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black,
                ),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      // title: Text(months[index % months.length]),
                      subtitle:
                          Text(messages[index % messages.length].toString()),
                    ),
                  );
                },
              );
            },
          ),
        ));
  }

  fetchSMS(
    List messages,
    Map months,
    List allMessages,
  ) async {
    List<String> banks = ['CUB', 'SBI', 'HDFC', 'KOTAK', 'BOB'];
    List amounts = List.filled(12, 0.0, growable: false);
    List strAmounts = List.filled(12, null, growable: false);
    String? data;
    var userAmt;

    allMessages = await query.getAllSms;
    for (int i = 0; i < allMessages.length; i++) {
      if (allMessages[i].address != null) {
        for (int j = 0; j < banks.length; j++) {
          if (allMessages[i].address.contains(banks[j])) {
            if (allMessages[i].body.contains('is debited for') ||
                allMessages[i].body.contains('is debited by') ||
                allMessages[i].body.contains('is debited from')) {
              months.forEach((key, value) async {
                if (allMessages[i].date.toString().contains('2022-$key')) {
                  strAmounts[int.parse(key) - 1] =
                      allMessages[i].body.split("Rs.")[1].split(" ")[0];
                  amounts[int.parse(key) - 1] +=
                      double.parse(strAmounts[int.parse(key) - 1]);
                  await db
                      .collection('transactions')
                      .doc(uid)
                      .collection('details')
                      .doc(allMessages[i].date.toString())
                      .set({
                    'month': value,
                    'date': allMessages[i].date.toString().split(' ')[0],
                    'time': allMessages[i].date.toString().split(' ')[1],
                    'amount': strAmounts[int.parse(key) - 1]
                  });
                }
              });
            }
          }
        }
      }
    }
    months.forEach((key, value) {
      messages.add(amounts[int.parse(key) - 1]);
    });
  }

  // readSMS() async {
  //   receiver.onSmsReceived.listen((SmsMessage msg) {
  //     print(msg.address);
  //     print(msg.body);
  //     print(msg.sender);
  //     print(msg.runtimeType);
  //     print(msg.sender.toUpperCase());
  //   });
  // }

}
