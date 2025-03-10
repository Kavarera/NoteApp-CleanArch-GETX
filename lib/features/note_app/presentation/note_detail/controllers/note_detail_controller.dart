import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/features/note_app/domain/entities/category_entity.dart';
import 'package:noteapp/features/note_app/domain/usecases/get_all_category_usecase.dart';
import 'package:noteapp/features/note_app/domain/usecases/update_note_usecase.dart';
import 'package:noteapp/features/note_app/presentation/note_detail/controllers/custom_text_controller.dart';
import 'package:noteapp/features/note_app/presentation/routes/app_routes.dart';

import '../../../domain/entities/note_entity.dart';
import '../../../domain/usecases/add_new_note_usecase.dart';

class NoteDetailController extends GetxController {
  RxString? title;
  RxString? content;
  final _editState = false.obs;
  late FocusNode _focusNode;
  final categories = <CategoryEntity>[].obs;
  final Rx<CategoryEntity?> selectedCategory = Rx<CategoryEntity?>(null);

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
    //check for args
    var args = Get.arguments as NoteEntity?;
    if (args != null) {
      title = args.title.obs;
      content = args.content.obs;
      activeContentController.text = args.content;
      selectedCategory.value = args.category;
    }

    titleController.text = title!.value;
    activeContentController.addListener(activeContentControllerListener);

    _getCategories();
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
    // _focusNode.addListener(() {
    //   if (_focusNode.hasFocus) {
    //     log("Focus Node has focus");
    //   } else {
    //     log("Focus Node lost focus");
    //   }
    // });
  }
  FocusNode getFocusNode() {
    return _focusNode;
  }

  void saveNote() async {
    try {
      final useCase = Get.find<InsertNoteUseCase>();
      final noteId = Get.arguments?.id ?? 0;
      final category = selectedCategory.value;
      Get.log("Category: $category");
      final noteEntity = NoteEntity(
        id: noteId,
        title: titleController.text,
        content: content?.value ?? "",
        category: category,
      );
      Get.log(
          "Note Entity: $noteEntity, NE Category: ${noteEntity.category?.name}");
      if (noteId == 0) {
        await useCase(noteEntity);
        Get.log("Created new note");
      } else {
        await Get.find<UpdateNoteUsecase>()(noteEntity);
        Get.log("Saved note");
        Get.log("""Note Category = ${noteEntity.category?.name}\n
            Data title = ${noteEntity.title}
            Note Category ID = ${noteEntity.category?.id}
            """);
      }
    } catch (e) {
      Get.offAllNamed(AppRoutes.home, arguments: false);
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

  void _getCategories() async {
    final data = await Get.find<GetAllCategoriesUseCase>()();
    data.fold(
      (failure) {
        Get.snackbar("Error", "Failed to get categories");
      },
      (data) {
        categories.assignAll(data);
      },
    );
  }

  void changeSelectedCategory(int index) {
    selectedCategory.value = categories.where((e) => e.id == index).firstOrNull;
  }

  void clearSelectedCategory() {
    selectedCategory.value = null;
  }
}
