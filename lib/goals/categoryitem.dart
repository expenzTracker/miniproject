import 'package:flutter/material.dart';
import 'classes/category.dart';

class CategoryItem extends StatelessWidget {

  final Category item;
  final Function _deleteCategory;
  final Function _editCategory;

  const CategoryItem(this.item, this._editCategory, this._deleteCategory, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(30.0)),
      child: Column(
        children: [
          ListTile(
                  title: Text(item.name,style: TextStyle(fontSize: 30),),
          ),
          ListTile(
                  title: Text(item.amount),
          ),
          ButtonBar(
                  alignment: MainAxisAlignment.center,                  
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      onPressed: () => _editCategory(item),
                      child: const Text('Edit'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      onPressed: () => _deleteCategory(item),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
        ]
      )
    );
  }
}
