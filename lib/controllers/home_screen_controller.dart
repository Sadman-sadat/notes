import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/services/firebase_services.dart';

class HomeScreenController extends GetxController {
  final FirebaseService _firebaseService = Get.find<FirebaseService>();
  final _notes = <NoteModel>[].obs;
  final _isLoading = false.obs;

  List<NoteModel> get notes => _notes.value;

  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    checkAuthStatus();
  }

  void checkAuthStatus() {
    final auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((User? user) {
      if (user != null) {
        fetchNotes();
      } else {
        GoRouter.of(Get.context!).go('/login');
      }
    });
  }

  void fetchNotes() {
    _isLoading.value = true;
    _firebaseService.printUserData();
    _firebaseService.fetchNotes().listen(
      (notes) {
        _notes.value = notes;
        _isLoading.value = false;
        print('Fetched ${notes.length} notes');
      },
      onError: (error) {
        print('Error fetching notes: $error');
        _isLoading.value = false;
      },
    );
  }

  void refreshNotes() {
    fetchNotes();
  }

  Future<void> logout(BuildContext context) async {
    await _firebaseService.logOut().then((_) {
      _notes.clear();
      context.go('/login');
    });
  }
}
