import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:noteapp/core/errors/failure.dart';
import 'package:noteapp/features/note_app/domain/usecases/get_all_category_usecase.dart';

import '../../../domain/usecases/get_all_notes.dart';
import '../../../domain/entities/note_entity.dart';

class HomeController extends GetxController {
  final GetAllNotesUseCase getAllNotesUseCase;
  final GetAllCategoriesUseCase getAllCategoriesUseCase;

  var notes = <NoteEntity>[].obs;
  var isGrid = true.obs;

  HomeController(
      {required this.getAllNotesUseCase,
      required this.getAllCategoriesUseCase});

  @override
  void onReady() async {
    super.onReady();
    final data = await getAllNotesUseCase.call();
    getAllNotes(data);
  }

  void getAllNotes(Either<Failure, List<NoteEntity>> data) {
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
      },
    );
  }

  void ChangeViewType() {
    isGrid.value = !isGrid.value;
  }
}
