import 'package:flutter/material.dart';
import 'classes/category.dart';
import 'categoryitem.dart';

class CategoryList extends StatelessWidget{

  final List<Category> _todos;
  final Function _deleteToDo;
  final Function _editTodo;

  const CategoryList(this._todos, this._editTodo, this._deleteToDo, {Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _todos.length,
                  padding: const EdgeInsets.only(bottom: 60),
                  shrinkWrap: true, 
                  itemBuilder: (context, index) {
                    final item = _todos[index];
                    return CategoryItem(item, _editTodo, _deleteToDo);
                  },
                );
  }
}