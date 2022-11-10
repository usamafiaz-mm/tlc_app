import 'package:flutter/material.dart';
import 'package:tlc_app/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/splash-screen";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: FittedBox(
          child: Text(
            "TLC APP",
            style: TextStyle(
                fontSize: 100,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.purple, Colors.deepOrange, Colors.pinkAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
      ),
    );
  }

  @override
  void initState() {
    Future.delayed(Duration(microseconds: 130), () {}).then((value) {
      Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
    });
  }
}
