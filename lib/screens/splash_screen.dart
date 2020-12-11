import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {

  static const String _id = 'splash';
  static String get id => _id;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    startSplash();
  }

  startSplash() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, () => Navigator.popAndPushNamed(context, 'login'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: AppBar(),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Image.asset(
          'assets/icons/brand.png',
          width: MediaQuery.of(context).size.width * 0.4,
        ),
      )
    );
  }
}