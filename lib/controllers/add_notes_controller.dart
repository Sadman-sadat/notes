import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/services/firebase_services.dart';

class AddNotesScreenController extends GetxController {
  final FirebaseService _firebaseService = Get.find<FirebaseService>();

  final formKey = GlobalKey<FormState>();
  final titleTEController = TextEditingController();
  final descriptionTEController = TextEditingController();

  Future<void> addNote(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      await _firebaseService.addNote(
        titleTEController.text,
        descriptionTEController.text,
      );
      titleTEController.clear();
      descriptionTEController.clear();
      context.go('/home');
    } else {
      Get.snackbar(
        'Error',
        'Please fill all fields correctly',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    titleTEController.dispose();
    descriptionTEController.dispose();
    super.onClose();
  }
}