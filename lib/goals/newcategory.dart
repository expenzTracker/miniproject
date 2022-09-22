import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/classes/color_palette.dart';
import 'package:flutter/material.dart';
import '../classes/category.dart';

final db = FirebaseFirestore.instance;
final user = FirebaseAuth.instance.currentUser;
final uid = user?.uid;

class NewCategory extends StatelessWidget {
  final Function _addCategory;
  final Function _clear;
  final Category? _category;
  final TextEditingController nameController;
  final TextEditingController amountController;

  const NewCategory(this.nameController, this.amountController,
      this._addCategory, this._clear, this._category,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'name',
            ),
            controller: nameController,
            autofocus: true,
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: 'amount',
            ),
            controller: amountController,
            autofocus: true,
          ),
          ButtonBar(alignment: MainAxisAlignment.center, children: [
            ElevatedButton(
              onPressed:
                  nameController.text.isNotEmpty ? () => _addCategory() : null,
              style: ButtonStyle(
                backgroundColor: nameController.text.isNotEmpty
                    ? MaterialStateProperty.all<Color>(Colors.black)
                    : null,
                overlayColor:
                    MaterialStateProperty.all<Color>(ColorPalette.piggyGrey),
              ),
              child: Text((_category != null && nameController.text.isNotEmpty)
                  ? 'Edit '
                  : 'Add '),
            ),
            Visibility(
                visible: nameController.text.isNotEmpty ||
                    amountController.text.isNotEmpty,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: ColorPalette.piggyPinkDark,
                  ),
                  onPressed: () => _clear(),
                  child: const Text('Clear'),
                )),
          ])
        ],
      ),
    );
  }
}
