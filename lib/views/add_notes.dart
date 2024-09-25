import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controllers/add_notes_controller.dart';

class AddNotesScreen extends StatelessWidget {
  AddNotesScreen({super.key});

  final AddNotesScreenController _addNotesScreenController  = Get.find<AddNotesScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Notes')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _addNotesScreenController.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _addNotesScreenController.titleTEController,
                decoration: const InputDecoration(hintText: 'Enter new note title'),
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter your title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addNotesScreenController.descriptionTEController,
                maxLines: 10,
                decoration: const InputDecoration(hintText: 'Enter new note description'),
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter your description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _addNotesScreenController.addNote(context);
                  },
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}