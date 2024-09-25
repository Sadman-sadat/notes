import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  String id;
  String title;
  String description;
  DateTime createdAt;

  NoteModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'created_at': createdAt,
    };
  }

  static NoteModel fromMap(Map<String, dynamic> map, String id) {
    return NoteModel(
      id: id,
      title: map['title'],
      description: map['description'],
      createdAt: (map['created_at'] as Timestamp).toDate(),
    );
  }
}
