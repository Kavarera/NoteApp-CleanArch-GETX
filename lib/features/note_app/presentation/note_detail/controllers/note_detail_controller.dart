import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/core/errors/failure.dart';
import 'package:noteapp/features/note_app/presentation/note_detail/controllers/custom_text_controller.dart';
import 'package:noteapp/features/note_app/presentation/routes/app_routes.dart';

import '../../../domain/entities/note_entity.dart';
import '../../../domain/usecases/add_new_note_usecase.dart';

class NoteDetailController extends GetxController {
  RxString? title;
  RxString? content;
  final _editState = false.obs;
  late FocusNode _focusNode;

  var isSelection = false.obs;

  late TextEditingController titleController;
  late CustomTextController activeContentController;

  List<Map<String, dynamic>> textData = [];

  bool get getEditState => _editState.value;

  @override
  void onInit() {
    super.onInit();
    titleController = TextEditingController();
    activeContentController = CustomTextController();

    titleController.text = title!.value;
    activeContentController.addListener(activeContentControllerListener);
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
      }
    });
  }
  FocusNode getFocusNode() {
    return _focusNode;
  }

  void saveNote() {
    try {
      Get.find<InsertNoteUseCase>()(NoteEntity(
        id: 0,
        title: titleController.text,
        content: activeContentController.text,
      ));
      Get.log("NOTE SAVED");
    } catch (e) {
      if (e.runtimeType == CacheFailure) {
        Get.snackbar("Error", "Failed to save note");
      }
    }

    Get.offAllNamed(AppRoutes.home);
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
      log("Going to do unfocus focusnode");
      _focusNode.unfocus();
    }
  }

  void activeContentControllerListener() {
    final selection = activeContentController.selection;

    if (selection.baseOffset != selection.extentOffset) {
      isSelection.value = true;
    } else {
      isSelection.value = false;
    }
  }

  applyFormat(String s) {
    if (!_focusNode.hasFocus) {
      return;
    }
    if (isSelection.value == false) {
      if (s == 'i') {
        activeContentController.text += "[[i]][[/i]]";
      }
      if (s == 'b') {
        activeContentController.text += "[[b]][[/b]]";
      }
      if (s == 'u') {
        activeContentController.text += "[[u]][[/u]]";
      }
      activeContentController.selection = TextSelection.fromPosition(
          TextPosition(
              offset: activeContentController.selection.baseOffset - 6));
    } else {
      Get.log("Woe");
      TextSelection sel = activeContentController.selection;
      if (sel.baseOffset != sel.extentOffset) {
        String curText = activeContentController.text
            .substring(sel.baseOffset, sel.extentOffset);
        activeContentController.text = activeContentController.text
            .replaceRange(
                sel.baseOffset, sel.extentOffset, "[[$s]]$curText[[/$s]]");
      }
    }
  }
}
