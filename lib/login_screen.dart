import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/home.dart';
import 'package:first_app/register_screen.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'classes/color_palette.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

final _auth = FirebaseAuth.instance;

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String password = "";
  bool _checkbox = false;
  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Stack(
        children: [
          // Image(
          //   image: const AssetImage("images/panda.jpg"),
          //   fit: BoxFit.cover,
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height,
          // ),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 7.0,
              sigmaY: 7.0,
            ),
            child: const Text("."),
          ),
          Align(
            alignment: const Alignment(0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterScreen()),
                    );
                  },
                  child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          color: ColorPallete.piggyBlack,
                          borderRadius: BorderRadius.circular(20)),
                      width: 270,
                      height: 50,
                      child: const Align(
                          alignment: Alignment(0, 0),
                          child: Text("Create an Account",
                              style: TextStyle(color: Colors.white)))),
                ),
                const SizedBox(height: 30),
                const Text("OR LOGIN WITH PASSWORD",
                    style: TextStyle(color: Color.fromRGBO(161, 164, 178, 1))),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.only(left: 40, right: 20),
                  margin: const EdgeInsets.only(top: 10),
                  width: 350,
                  child: TextFormField(
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Enter your email',
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.only(left: 40, right: 20),
                    width: 350,
                    child: TextFormField(
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Enter your password',
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                {
                                  _passwordVisible = !_passwordVisible;
                                }
                              });
                            },
                            icon: const Icon(Icons.visibility_off)),
                      ),
                      obscureText: _passwordVisible ? false : true,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const InkWell(
                        child: Text("I have read the Privacy Policy",
                            style: TextStyle(color: Colors.blue))),
                    Theme(
                      data: ThemeData(unselectedWidgetColor: Colors.white),
                      child: Checkbox(
                        value: _checkbox,
                        onChanged: (value) {
                          setState(() {
                            _checkbox = !_checkbox;
                          });
                        },
                        activeColor: Colors.white,
                        checkColor: Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                InkWell(
                  onTap: () async {
                    try {
                      UserCredential result =
                          await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                      if (result != null) {
                        final User user = result.user!;
                        final uid = user.uid;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Home(uid: uid)),
                        );
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Container(
                    width: 270,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(70, 71, 221, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Align(
                      alignment: Alignment(0, 0),
                      child: Text("Login"),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
