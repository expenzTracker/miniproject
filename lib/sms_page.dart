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
  // List contact=[];

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SMS Inbox"),
        backgroundColor: Colors.pink,
      ),
      body: FutureBuilder(
        future: fetchSMS(),
        builder: (context, snapshot) {
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              color: Colors.black,
            ),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: const Icon(
                    Icons.markunread,
                    color: Colors.pink,
                  ),
                  title: Text(messages[index].address),
                  subtitle: Text(
                    messages[index].body,
                    maxLines: 2,
                    style: const TextStyle(),
                  ),
                ),
              );
            },
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
    // messages = await query.querySms(address: '$first' 'CUB' '$last');
    messages = await query.getAllSms;
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
