import 'package:flutter/material.dart';
import 'package:sms_advanced/sms_advanced.dart';

import 'classes/color_palette.dart';
import 'components/navbar.dart';

class ShowInbox extends StatefulWidget {
  const ShowInbox({Key? key}) : super(key: key);

  @override
  State createState() {
    return ShowInboxState();
  }
}

class ShowInboxState extends State {
  SmsQuery query = SmsQuery();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List messages = [];
    List months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September'
    ];
    List allMessages = [];
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Monthly Expenditure"),
        backgroundColor: ColorPalette.piggyViolet,
      ),
      bottomNavigationBar: const Navbar(),
      body: FutureBuilder(
        future: fetchSMS(messages, months, allMessages),
        builder: (context, snapshot) {
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              color: Colors.white,
            ),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(months[index % months.length],
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  subtitle: Text(messages[index % messages.length],
                      style: const TextStyle(color: Colors.white)),
                ),
              );
            },
          );
        },
      ),
    );
  }

  fetchSMS(List messages, List months, List allMessages) async {
    // String first = "AX-";
    // String last = "LTD";
    // String last1 = "ANK";

    // String bank = 'CUB';
    // String bankAddress = '$first' '$bank' '$last';
    // if (bankAddress.contains('CUB')) {
    //   messages = await query.querySms(address: bankAddress);
    // };

    List<String> banks = ['CUB', 'SBI', 'HDFC', 'KOTAK', 'BOB'];
    var amount1 = 0.0,
        amount2 = 0.0,
        amount3 = 0.0,
        amount4 = 0.0,
        amount5 = 0.0,
        amount6 = 0.0,
        amount7 = 0.0,
        amount8 = 0.0,
        amount9 = 0.0;

    var strAmount1,
        strAmount2,
        strAmount3,
        strAmount4,
        strAmount5,
        strAmount6,
        strAmount7,
        strAmount8,
        strAmount9;

    allMessages = await query.getAllSms;
    for (int i = 0; i < allMessages.length; i++) {
      if (allMessages[i].address != null) {
        for (int j = 0; j < banks.length; j++) {
          if (allMessages[i].address.contains(banks[j])) {
            if (allMessages[i].body.contains('is debited for') ||
                allMessages[i].body.contains('is debited by') ||
                allMessages[i].body.contains('is debited from')) {
              if (allMessages[i].date.toString().contains('2022-09')) {
                strAmount9 = allMessages[i].body.split("Rs.")[1].split(" ")[0];
                amount9 += double.parse(strAmount9);
              } else if (allMessages[i].date.toString().contains('2022-08')) {
                strAmount8 = allMessages[i].body.split("Rs.")[1].split(" ")[0];
                amount8 += double.parse(strAmount8);
              } else if (allMessages[i].date.toString().contains('2022-07')) {
                strAmount7 = allMessages[i].body.split("Rs.")[1].split(" ")[0];
                amount7 += double.parse(strAmount7);
              } else if (allMessages[i].date.toString().contains('2022-06')) {
                strAmount6 = allMessages[i].body.split("Rs.")[1].split(" ")[0];
                amount6 += double.parse(strAmount6);
              } else if (allMessages[i].date.toString().contains('2022-05')) {
                strAmount5 = allMessages[i].body.split("Rs.")[1].split(" ")[0];
                amount5 += double.parse(strAmount5);
              } else if (allMessages[i].date.toString().contains('2022-04')) {
                strAmount4 = allMessages[i].body.split("Rs.")[1].split(" ")[0];
                amount4 += double.parse(strAmount4);
              } else if (allMessages[i].date.toString().contains('2022-03')) {
                strAmount3 = allMessages[i].body.split("Rs.")[1].split(" ")[0];
                amount3 += double.parse(strAmount3);
              } else if (allMessages[i].date.toString().contains('2022-02')) {
                strAmount2 = allMessages[i].body.split("Rs.")[1].split(" ")[0];
                amount2 += double.parse(strAmount2);
              } else if (allMessages[i].date.toString().contains('2022-01')) {
                strAmount1 = allMessages[i].body.split("Rs.")[1].split(" ")[0];
                amount1 += double.parse(strAmount1);
              }
            }
          }
        }
      }
      ;
    }
    messages.add(amount1.toString());
    messages.add(amount2.toString());
    messages.add(amount3.toString());
    messages.add(amount4.toString());
    messages.add(amount5.toString());
    messages.add(amount6.toString());
    messages.add(amount7.toString());
    messages.add(amount8.toString());
    messages.add(amount9.toString());
  }
}
