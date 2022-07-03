import 'package:flutter/material.dart';
import 'package:carismatic/ui/authentication/signin.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);


  @override _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State {
  @override void initState() {
    super.initState();
    Future.delayed( const Duration(seconds: 5), () =>
        Navigator.pushReplacement( context,
          MaterialPageRoute(builder: (context) => const SigninPage()),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset("assets/images/splash.gif",
                gaplessPlayback: true,
                fit: BoxFit.fill
            )
        ));
  }
}