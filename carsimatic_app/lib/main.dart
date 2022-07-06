
import 'package:flutter/material.dart';
import 'package:carismatic/ui/splash_screen.dart';
void main() async {


  runApp( MyApp());
}

class MyApp   extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Automobile Search',
      home: SplashScreenPage(),
    );
  }
}

