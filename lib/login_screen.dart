import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/home.dart';
import 'package:first_app/register_screen.dart';
import 'package:first_app/splash_screen.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

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
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20)),
                      width: 270,
                      height: 50,
                      child: const Align(
                          alignment: Alignment(0, 0),
                          child: Text("Create an Account",
                              style: TextStyle(color: Colors.white)))),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      alignment: const Alignment(0, 0),
                      width: 270,
                      height: 50,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: 10),
                            // FaIcon(FontAwesomeIcons.facebook,
                            //     color: Colors.white),
                            const SizedBox(width: 10),
                            const Text("Continue with Facebook",
                                style: TextStyle(color: Colors.white))
                          ]),
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(70, 71, 221, 1),
                          borderRadius: BorderRadius.circular(20))),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                      margin: EdgeInsets.only(top: 10),
                      width: 270,
                      height: 50,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: 10),
                            // FaIcon(FontAwesomeIcons.google,
                            //     color: Colors.white),
                            const SizedBox(width: 15),
                            const Text("Continue with Google",
                                style: TextStyle(color: Colors.white))
                          ]),
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(70, 71, 221, 1),
                          borderRadius: BorderRadius.circular(20))),
                ),
                SizedBox(height: 30),
                Text("OR LOGIN WITH PASSWORD",
                    style: const TextStyle(
                        color: Color.fromRGBO(161, 164, 178, 1))),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.only(left: 40, right: 20),
                  margin: EdgeInsets.only(top: 10),
                  width: 350,
                  child: TextFormField(
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Enter your email',
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.only(left: 40, right: 20),
                    width: 350,
                    child: TextFormField(
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Enter your password',
                        suffixIcon: Icon(Icons.visibility_off),
                      ),
                      obscureText: true,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
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
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Home()),
                        );
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Container(
                    width: 270,
                    height: 50,
                    child: const Align(
                      child: Text("Login"),
                      alignment: Alignment(0, 0),
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(70, 71, 221, 1),
                      borderRadius: BorderRadius.circular(20),
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
