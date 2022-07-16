import 'package:flutter/material.dart';

String dropdownvalue = 'State Bank of India';  
 
  // List of items in our dropdown menu
  var items = [   
    'State Bank of India',
    'City Union Bank',
    'HDFC Bank',
    'Axis Bank',
    'ICICI Bank',
    'Canara Bank',
    'Bank of Baroda',
    'South Indian Bank',
    'UCO Bank',
    'Dhanalaxmi Bank'
  ];

class ChooseBank extends StatefulWidget {
  const ChooseBank({Key? key}) : super(key: key);

  @override
  State<ChooseBank> createState() => _ChooseBankState();
}

class _ChooseBankState extends State<ChooseBank> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Bank'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
              value: dropdownvalue,
              icon: const Icon(Icons.keyboard_arrow_down),  
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
              )
            
          ],
        ),
      ),
    );
    
  }
}
