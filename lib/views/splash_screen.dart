import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controllers/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashScreenController _splashScreenController = Get.find<SplashScreenController>();

  @override
  Widget build(BuildContext context) {
    _splashScreenController.navigateToNextScreen(context);

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 250,
              width: 250,
              child: Image.asset('assets/notes.png'),
            ),
            const Text('Welcome to Notes App!', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}