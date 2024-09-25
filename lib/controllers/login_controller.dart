import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/services/firebase_services.dart';

class LoginController extends GetxController {
  final FirebaseService _firebaseService = Get.find<FirebaseService>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  RxBool isLoading = false.obs;

  Future<void> login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      User? user = await _firebaseService.logIn(
        emailController.text,
        passwordController.text,
      );
      isLoading.value = false;

      if (user != null) {
        emailController.clear();
        passwordController.clear();
        context.go('/home');
      } else {
        Get.snackbar(
        'Error',
        "Login Failed",
        snackPosition: SnackPosition.BOTTOM,
      );
      }
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
