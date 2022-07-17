import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sms_advanced/sms_advanced.dart';

class MyInbox extends StatefulWidget {
  const MyInbox({Key? key}) : super(key: key);

  @override
  State createState() {
    return MyInboxState();
  }
}

class MyInboxState extends State {
  // SmsReceiver receiver = new SmsReceiver();
  // ContactQuery contacts = new ContactQuery();
  SmsQuery query = SmsQuery();
  List messages = [];
  List allMessages = [];
  // List contact=[];

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;
    String? data;
    return Scaffold(
      appBar: AppBar(
        title: const Text("SMS Inbox"),
        backgroundColor: Colors.pink,
      ),
      body: FutureBuilder(
        future: fetchSMS(),
        builder: (context, snapshot) {
          data = messages[0];
              var userAmt = <String,dynamic>{
                "amount" : data
              };
              db
                .collection("debit")
                .doc(uid)
                .collection("amount")
                .add(userAmt);
          return Text(
            data.toString()
          );
        },
      ),
    );
  }

  // fetchContact() async {
  //   Contact contact = await contacts.queryContact('8589908457');
  //   print(contact.fullName);
  // }
  fetchSMS() async {
    // String first = "AX-";
    // String last = "LTD";
    // String last1 = "ANK";
    
    // String bank = 'CUB';
    // String bankAddress = '$first' '$bank' '$last';
    // if (bankAddress.contains('CUB')) {
    //   messages = await query.querySms(address: bankAddress);
    // };

    List <String> banks =['CUB','SBI','HDFC','KOTAK','BOB'];
    var amount=0.0;
    var strAmount;
    
    allMessages = await query.getAllSms;
    for (int i=0;i<allMessages.length;i++){
      if (allMessages[i].address!= null){
        for(int j=0;j<banks.length;j++){
          if (allMessages[i].address.contains(banks[j])){
            if (allMessages[i].body.contains('is debited for') || allMessages[i].body.contains('is debited by') || allMessages[i].body.contains('is debited from')){
              strAmount = allMessages[i].body.split("Rs.")[1].split(" ")[0];
              amount+=double.parse(strAmount);
            }
          }   
        }  
      };
    }
    messages.add(amount.toString());
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

  // await query.querySms({
  //   kinds: [SmsQueryKind.Inbox, SmsQueryKind.Sent]
  // });
}
