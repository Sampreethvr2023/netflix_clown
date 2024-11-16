import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
    return Scaffold(
      body: Center(
        child:
            Image.asset('assets/splash_image.png'), // Replace with your image
      ),
    );
  }
}
