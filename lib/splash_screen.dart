import 'package:flutter/material.dart';
import 'dart:async';
import 'login_screen.dart';
import 'register_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  // const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack( 
          children: [
            // Image(
            //   image: const AssetImage("images/piggybank.jpg"),
            //   fit: BoxFit.cover,
            //   width: MediaQuery.of(context).size.width,
            //   height: MediaQuery.of(context).size.height,
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      const Image(
                        //logo
                        image: AssetImage("images/piggy.png"),
                        height: 50,
                        // fit: BoxFit.cover,
                      ),
                      Text("MyPiggy")
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
