import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/core/errors/failure.dart';
import 'package:noteapp/features/note_app/domain/entities/category_entity.dart';
import 'package:noteapp/features/note_app/domain/usecases/add_new_category_usecase.dart';
import 'package:noteapp/features/note_app/domain/usecases/get_all_category_usecase.dart';
import 'package:noteapp/features/note_app/presentation/routes/app_routes.dart';

import '../../../domain/usecases/delete_category_usecase.dart';
import '../../../domain/usecases/delete_note_usecase.dart';
import '../../../domain/usecases/get_all_notes.dart';
import '../../../domain/entities/note_entity.dart';
import '../widgets/new_category_dialog_widget.dart';

class HomeController extends GetxController {
  final GetAllNotesUseCase getAllNotesUseCase;

  final GetAllCategoriesUseCase getAllCategoriesUseCase;
  final InsertCategoryUseCase insertCategoryUseCase;

  var notes = <NoteEntity>[].obs;
  var categories = <CategoryEntity>[].obs;
  var isGrid = true.obs;

  final TextEditingController _newCategoryController = TextEditingController();

  HomeController({
    required this.getAllNotesUseCase,
    required this.getAllCategoriesUseCase,
    required this.insertCategoryUseCase,
  });

  @override
  void onReady() async {
    super.onReady();
    final data = await getAllNotesUseCase.call();
    final c = await getAllCategoriesUseCase.call();
    getAllData(data, c);
  }

  void getAllData(Either<Failure, List<NoteEntity>> data,
      Either<Failure, List<CategoryEntity>> c) {
    _getAllNotes(data);
    _getAllCategories(c);
  }

  void _getAllNotes(Either<Failure, List<NoteEntity>> data) {
    data.fold(
      (failure) {
        Get.snackbar(
          "Error",
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor,
        );
        log("${failure.message} Error: ${failure.runtimeType}");
      },
      (data) {
        notes.value = data;
        data.forEach((e) => Get.log(
            "Note Category = ${e.category?.name} Data title = ${e.title}"));
      },
    );
  }

  void _getAllCategories(Either<Failure, List<CategoryEntity>> c) {
    c.fold(
      (failure) {
        _showErrorSnackbar("Failed to load categories");
        log("${failure.message} Error: ${failure.runtimeType}");
      },
      (c) {
        categories.clear();
        if (c.isNotEmpty) {
          categories.add(CategoryEntity(id: -2, name: "All"));
        }
        for (var category in c) {
          categories.add(category);
        }
        categories.add(CategoryEntity(id: -1, name: "Add Category"));
      },
    );
  }

  void changeViewType() {
    isGrid.value = !isGrid.value;
  }

  void addCategory() {
    Get.dialog(
      NewCategoryDialogWidget(
        onAddCategory: () => _addCategory(),
        controller: _newCategoryController,
      ),
    );
  }

  void _addCategory() async {
    if (_newCategoryController.text.isNotEmpty) {
      final data = await insertCategoryUseCase.call(
        CategoryEntity(name: _newCategoryController.text),
      );
      data.fold(
        (failure) {
          _showErrorSnackbar("Failed to add category");
        },
        (data) async {
          Get.back();
          _newCategoryController.clear();
          final c = await getAllCategoriesUseCase.call();
          _getAllCategories(c);
        },
      );
    }
  }

  newNote() {
    Get.offAllNamed(AppRoutes.noteDetail);
  }

  editNote(int index) {
    Get.offAllNamed(AppRoutes.noteDetail, arguments: notes.elementAt(index));
  }

  void removeNote(int index) async {
    try {
      await Get.find<DeleteNoteUsecase>()(notes.elementAt(index).id);
      notes.removeAt(index);
    } catch (e) {
      _showErrorSnackbar("Failed to remove data");
    }
  }

  void removeCategory(int? id) async {
    try {
      await Get.find<DeleteCategoryUsecase>()(id!);
      categories.removeWhere((element) => element.id == id);
    } catch (e) {
      _showErrorSnackbar("Failed to remove category");
    }
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      "Error",
      "Failed to delete note",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Colors.black,
      borderColor: Colors.red,
      borderRadius: 0,
      margin: const EdgeInsets.only(bottom: 20),
    );
  }
}
