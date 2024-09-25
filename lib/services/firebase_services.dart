import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes/models/note_model.dart';

class FirebaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User?> registration(
      String firstName, String lastName, String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      await userCredential.user?.updateDisplayName('$firstName $lastName');

      User? user = userCredential.user;

      await _firebaseFirestore.collection('users').doc(user?.uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'createdAt': DateTime.now().toIso8601String(),
      });

      return userCredential.user;
    } catch (e) {
      print('Error during sign-up: $e');
      return null;
    }
  }

  Future<User?> logIn(String email, String password) async {
    try {
      UserCredential userCredential =
        await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('error during login: $e');
      return null;
    }
  }

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  User? get currentUser {
    return _firebaseAuth.currentUser;
  }

  String? get userID => _firebaseAuth.currentUser?.uid;

  Future<void> addNote(String title, String description) async {
    try{
      if (userID == null) {
        print('Error: No user logged in');
        return;
      }
      final note = NoteModel(
        id: '',
        title: title,
        description: description,
        createdAt: DateTime.now(),
      );
      await _firebaseFirestore
          .collection('users')
          .doc(userID)
          .collection('notes')
          .add(note.toMap());
      print('Note added for user: $userID');
    } catch (e) {
      print('error during adding note: $e');
      return null;
    }
  }

  Stream<List<NoteModel>> fetchNotes() {
    if (userID == null) {
      print('Error: No user logged in');
      return Stream.value([]);
    }
    print('Fetching notes for user: $userID');
    return _firebaseFirestore
        .collection('users')
        .doc(userID)
        .collection('notes')
        .orderBy('created_at', descending: true)
        .snapshots()
        .map((snapshot) {
      print('Received snapshot with ${snapshot.docs.length} documents');
      return snapshot.docs.map((doc) {
        print('Processing document: ${doc.id}');
        return NoteModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  Future<void> printUserData() async {
    print('Current user: ${currentUser?.uid}');
    print('User ID from getter: $userID');
    try {
      var userData = await _firebaseFirestore.collection('users').doc(userID).get();
      print('User data: ${userData.data()}');
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }
}
