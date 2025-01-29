import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/core/errors/failure.dart';
import 'package:noteapp/features/note_app/domain/entities/category_entity.dart';
import 'package:noteapp/features/note_app/domain/usecases/add_new_category_usecase.dart';
import 'package:noteapp/features/note_app/domain/usecases/get_all_category_usecase.dart';

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

  TextEditingController _newCategoryController = TextEditingController();

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
        log(notes.value.runtimeType.toString());
      },
    );
  }

  void _getAllCategories(Either<Failure, List<CategoryEntity>> c) {
    c.fold(
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
      (c) {
        categories.clear();
        for (var category in c) {
          log(" c=  ${category.name}- ${category.id}");
          categories.add(category);
        }
        categories.add(CategoryEntity(id: -1, name: "Add Category"));
        for (var category in categories) {
          log("Category: ${category.name}- ${category.id}");
        }
      },
    );
  }

  void ChangeViewType() {
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
          Get.snackbar(
            "Error",
            failure.message,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Get.theme.snackBarTheme.backgroundColor,
            colorText: Get.theme.snackBarTheme.actionTextColor,
          );
          log("${failure.message} Error: ${failure.runtimeType}");
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

  newNote() {}
}
