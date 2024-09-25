import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class SplashScreenController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void navigateToNextScreen(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      final isLoggedIn = _firebaseAuth.currentUser != null;
      if (isLoggedIn) {
        context.go('/home');
      } else {
        context.go('/login');
      }
    });
  }
}
