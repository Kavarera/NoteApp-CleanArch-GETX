import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/core/dummy_data.dart';
import 'package:noteapp/features/note_app/presentation/note_detail/controllers/note_detail_controller.dart';

class NoteDetailPage extends GetView<NoteDetailController> {
  const NoteDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        log("PAGE Popped with result: $result");
        controller.popAction(didPop, result);
      },
      child: Scaffold(
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
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            width: double.infinity,
            color: Colors.grey,
            child: Obx(
              () {
                log("UI: ${controller.content}");
                log("UI: ${controller.getEditState}");

                if (controller.content == null ||
                    controller.content!.value.isEmpty) {
                  if (!controller.getEditState) {
                    return InkWell(
                      onTap: () {
                        controller.changeEditState();
                      },
                      child: Text(
                        "Tap to add content",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else {
                    return TextField(
                      controller: controller.activeContentController,
                      focusNode: controller.getFocusNode(),
                      decoration: InputDecoration(
                        hintText: "Buy 100 eggs",
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    );
                  }
                } else {
                  return Text(
                    controller.content!.value,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
