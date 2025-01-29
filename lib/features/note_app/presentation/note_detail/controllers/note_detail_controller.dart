import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/features/note_app/presentation/routes/app_routes.dart';

class NoteDetailController extends GetxController {
  final RxString? title;
  final RxList<String>? content;

  late TextEditingController titleController;
  late TextEditingController activeContentController;

  @override
  void onInit() {
    super.onInit();
    titleController = TextEditingController();
    activeContentController = TextEditingController();
    if (title != null) {
      titleController.text = title!.value;
    } else {
      titleController.text = "Untitled Note";
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    activeContentController.dispose();
    super.onClose();
  }

  NoteDetailController({this.title, this.content});

  void saveNote() {
    Get.offAllNamed(AppRoutes.home);
  }
}
