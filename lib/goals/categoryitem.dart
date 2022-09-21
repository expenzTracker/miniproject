import 'dart:ui';
import 'package:flutter/material.dart';
import '../classes/category.dart';
import '../classes/color_palette.dart';

class CategoryItem extends StatelessWidget {
  final Category item;
  final Function _deleteCategory;
  final Function _editCategory;

  const CategoryItem(this.item, this._editCategory, this._deleteCategory,
      {Key? key})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: const BorderSide(
            color: Colors.orange,
          ),
        ),
        child: Column(children: [
          ListTile(
            title: Text(
              item.name,
              style: const TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
          ListTile(
            title: Text(
              item.amount,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.orange),
                onPressed: () => _editCategory(item),
                child: const Text('Edit'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.orange),
                onPressed: () => _deleteCategory(item),
                child: const Text('Delete'),
              ),
            ],
          ),
        ]));
  }
}
