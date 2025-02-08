import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/features/note_app/presentation/routes/app_routes.dart';

class NoteDetailController extends GetxController {
  RxString? title;
  RxString? content;
  var _editState = false.obs;
  late FocusNode _focusNode;

  late TextEditingController titleController;
  late TextEditingController activeContentController;

  List<Map<String, dynamic>> textData = [];

  bool get getEditState => _editState.value;

  @override
  void onInit() {
    super.onInit();
    titleController = TextEditingController();
    activeContentController = TextEditingController();

    titleController.text = title!.value;
    titleController.addListener(titleControllerListener);
  }

  @override
  void onClose() {
    titleController.dispose();
    activeContentController.dispose();
    super.onClose();
  }

  NoteDetailController({String? title, String? content}) {
    _focusNode = FocusNode();
    if (title == null) {
      this.title = "Untitled Note".obs;
    }
    if (content == null) {
      this.content = "".obs;
    }
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        log("Focus Node has focus");
      } else {
        log("Focus Node lost focus");
        changeEditState();
      }
    });
  }
  FocusNode getFocusNode() {
    return _focusNode;
  }

  void saveNote() {
    Get.offAllNamed(AppRoutes.home);
  }

  void titleControllerListener() {
    log("Title: ${titleController.text}");
  }

  void popAction(bool didPop, Object? result) {
    Get.offAllNamed(AppRoutes.home);
  }

  void changeEditState() {
    _editState.value = !_editState.value;
    if (_editState.value) {
      _focusNode.requestFocus();
    } else {
      content!.value = activeContentController.text;
      _focusNode.unfocus();
    }
  }
}
