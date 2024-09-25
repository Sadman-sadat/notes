import 'package:get/get.dart';
import 'package:notes/controllers/add_notes_controller.dart';
import 'package:notes/controllers/home_screen_controller.dart';
import 'package:notes/controllers/login_controller.dart';
import 'package:notes/controllers/registration_controller.dart';
import 'package:notes/controllers/splash_screen_controller.dart';
import 'package:notes/services/firebase_services.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>FirebaseService());
    Get.lazyPut(()=>SplashScreenController());
    Get.lazyPut(()=>LoginController());
    Get.lazyPut(()=>RegistrationController());
    Get.lazyPut(()=>HomeScreenController());
    Get.lazyPut(()=>AddNotesScreenController());
  }
}