import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/features/note_app/presentation/note_detail/controllers/note_detail_controller.dart';

class NoteDetailPage extends GetView<NoteDetailController> {
  const NoteDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: controller.titleController,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => controller.saveNote(),
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Text("Hello World"),
        ),
      ),
    );
  }
}
