import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'home.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

final _auth = FirebaseAuth.instance;

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {});
    });
  }

  String email = "";
  String password = "";
  bool _checkbox = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            // new Image(
            //   image: new AssetImage("images/splash.jpg"),
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
            SingleChildScrollView(
              child: Align(
                alignment: const Alignment(0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen())),
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20)),
                        width: 270,
                        height: 50,
                        child: const Align(
                          alignment: Alignment(0, 0),
                          child: Text(
                            "Login to your Account",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        alignment: const Alignment(0, 0),
                        width: 270,
                        height: 50,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(70, 71, 221, 1),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SizedBox(width: 10),
                            // FaIcon(FontAwesomeIcons.facebook,
                            //     color: Colors.white),
                            SizedBox(width: 10),
                            Text("Continue with Facebook",
                                style: TextStyle(color: Colors.white))
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: 270,
                        height: 50,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(70, 71, 221, 1),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SizedBox(width: 10),
                            // FaIcon(FontAwesomeIcons.google,
                            //     color: Colors.white),
                            SizedBox(width: 15),
                            Text("Continue with Google",
                                style: TextStyle(color: Colors.white))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text("OR CREATE NEW ACCOUNT",
                        style:
                            TextStyle(color: Color.fromRGBO(161, 164, 178, 1))),
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
                          //Do something with the user input.
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
                            //Do something with the user input.
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Enter your password',
                            suffixIcon: Icon(Icons.visibility_off),
                          ),
                          obscureText: true,
                        )),
                    Container(
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.only(left: 40, right: 20),
                        width: 350,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Confirm your password',
                            suffixIcon: Icon(Icons.visibility_off),
                          ),
                          obscureText: true,
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
                        )
                      ],
                    ),
                    const SizedBox(height: 40),
                    InkWell(
                      onTap: () async {
                        try {
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          if (newUser != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Home(),
                              ),
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
                          child: Text("Get Started"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
