// import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/classes/color_palette.dart';
import 'package:flutter/material.dart';
// import 'add_category_route.dart';
import '../classes/category.dart';
import 'newcategory.dart';
import 'categoryitem.dart';
import 'categorylist.dart';

final db = FirebaseFirestore.instance;
final user = FirebaseAuth.instance.currentUser;
final uid = user?.uid;

class MyGoals extends StatefulWidget {
  const MyGoals({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MyGoalsState();
}

class _MyGoalsState extends State<MyGoals> {
  String amount = '';
  String name = '';
  int maxId = 0;
  Category? category;
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    nameController.addListener(_handleNameChange);
    amountController.addListener(_handleAmountChange);
  }

  void _handleNameChange() {
    setState(() {
      name = nameController.text;
    });
  }

  void _handleAmountChange() {
    setState(() {
      amount = amountController.text;
    });
  }

  void _addCategory() {
    final category = Category(name: name, amount: amount);

    var cat = {
      'name': category.name,
      'amount': category.amount,
    };

<<<<<<< HEAD
      var cat = {
        'name' : category.name,
        'amount':category.amount,
      };

      db.collection('goals').doc(uid).collection('categories').add(cat);
=======
    db.collection('goals').doc(uid).collection('categories').add(cat);

    setState(() {
      categories.add(category);
    });
>>>>>>> d032b344a5257e0488409f5bf5e1e5c2bae974d6

    setState(() {
      amount = '';
      maxId = maxId++;
      name = '';
    });

    amountController.text = '';
    nameController.text = '';
  }

  void _editCategory(Category categoryitem) {
    setState(() {
       categories = List.from(categories)..removeAt(categories.indexOf(categoryitem));
      category = categoryitem;
      amount = categoryitem.amount;
      name = categoryitem.name;
    });

    amountController.text = categoryitem.amount;
    nameController.text = categoryitem.name;

    _renderShowModal();
  }

  void _deleteCategory(Category categoryitem) {
    setState(() {
      categories = List.from(categories)
        ..removeAt(categories.indexOf(categoryitem));
    });
  }

  void _clear() {
    amountController.text = '';
    nameController.text = '';
    setState(() {
      amount = '';
      name = '';
      category = null;
    });
  }

  _renderShowModal() {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return ValueListenableBuilder(
            valueListenable: nameController,
            builder: (context, amount, child) {
              return NewCategory(nameController, amountController, _addCategory,
                  _clear, category);
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.piggyBlack,
      appBar: AppBar(
        title: const Text('My Goals'),
        backgroundColor: ColorPalette.piggyViolet,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextFormField(
                  onChanged: (value) {
                    amount = value;
                    print(amount);
                  },
<<<<<<< HEAD
                 decoration: InputDecoration(
      
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(40)
                   ),
                   hintText: 'Enter your monthly goals',
                   filled: true,
                   fillColor: Colors.grey,
                   ),
      
                   ),
               ),
      
=======
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40)),
                    hintText: 'Enter your monthly goals',
                    filled: true,
                    fillColor: Colors.grey,
                  ),
                ),
              ),
>>>>>>> d032b344a5257e0488409f5bf5e1e5c2bae974d6
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: ColorPalette.piggyGreenDark
                ),
                child: const Text('Set Goal'),
                onPressed: () {
                  db.collection('goals').doc(uid).set(
                    {
                      'monthly_goal': amount,
                    },
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
<<<<<<< HEAD
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color:Colors.grey,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical:20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                        child: Text('Categories',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      ),
                      CategoryList(categories, _editCategory, _deleteCategory),
                      Container( 
                        width:100,
                        height:100,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: TextButton(
                          onPressed: () {
                            _renderShowModal();
                          },
                          child: const Text('Add category',style: TextStyle(color: Colors.grey),),
                          ) ,
                        ),
                      ]
                    ),
                  )
                )
=======
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 20),
                            child: Text(
                              'Categories',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          CategoryList(
                              categories, _editCategory, _deleteCategory),
                          Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            child: TextButton(
                              onPressed: () {
                                _renderShowModal();
                              },
                              child: const Text(
                                'Add category',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ]),
                  ))
>>>>>>> d032b344a5257e0488409f5bf5e1e5c2bae974d6
            ],
          ),
        ),
      ),
    );
  }
}
