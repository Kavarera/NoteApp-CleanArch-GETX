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
        ),
      ),
      body: Container(
        child: Text("Hello World"),
      ),
    );
  }
}
