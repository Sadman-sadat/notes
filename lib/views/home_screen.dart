import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/controllers/home_screen_controller.dart';
import 'widgets/note_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeScreenController homeScreenController =
      Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeScreenController.refreshNotes();
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Log Out',
            onPressed: () {
              homeScreenController.logout(context);
            },
          ),
        ],
      ),
      body: Obx(() {
        if (homeScreenController.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (homeScreenController.notes.isEmpty) {
          return const Center(child: Text("No notes available"));
        }

        return RefreshIndicator(
          onRefresh: () async {
            homeScreenController.refreshNotes;
          },
          child: ListView.builder(
            itemCount: homeScreenController.notes.length,
            itemBuilder: (context, index) {
              final note = homeScreenController.notes[index];
              return NoteCard(note: note);
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/addNote');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
