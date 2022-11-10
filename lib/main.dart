import 'package:flutter/material.dart';
import 'package:tlc_app/screens/form_screen.dart';
import 'package:tlc_app/screens/main_screen.dart';
import 'package:tlc_app/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TLC APP',
      theme: ThemeData(
        primarySwatch: Colors.green,
        focusColor: Colors.green,
        scaffoldBackgroundColor: Color(0xFFEDEDED),
        textTheme: Theme.of(context).textTheme.copyWith(
            labelMedium: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            headline3: Theme.of(context)
                .textTheme
                .headline3
                ?.copyWith(color: Colors.black)),
        inputDecorationTheme: InputDecorationTheme(
            fillColor: Colors.green.withOpacity(0.4),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green, width: 2))),
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        MainScreen.routeName: (context) => MainScreen(),
        FormScreen.routeName: (context) => FormScreen()
      },
    );
  }
}
