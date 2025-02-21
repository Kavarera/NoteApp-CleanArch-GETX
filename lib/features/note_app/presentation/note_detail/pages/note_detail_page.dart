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
        controller.popAction(didPop, result);
      },
      child: Scaffold(
        floatingActionButton: Obx(() => Visibility(
              visible: controller.getEditState,
              child: FloatingActionButton(
                onPressed: () {
                  controller.changeEditState();
                },
                child: Icon(Icons.check),
              ),
            )),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Visibility(
                    visible: controller.isSelection.value,
                    child: BottomAppBar(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.format_bold),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.format_italic),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.format_underline),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.format_list_bulleted),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.format_list_numbered),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(
                    () {
                      log("UI: ${controller.content}");
                      log("UI: ${controller.getEditState}");

                      if (controller.getEditState) {
                        return TextField(
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          controller: controller.activeContentController,
                          focusNode: controller.getFocusNode(),
                          decoration: InputDecoration(
                            hintText: "Buy 100 eggs",
                          ),
                          style: Theme.of(context).textTheme.titleLarge,
                        );
                      } else {
                        return InkWell(
                          onTap: () {
                            controller.changeEditState();
                          },
                          child: Text(
                            controller.content!.value.isEmpty
                                ? "Tap to add content"
                                : controller.content!.value,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
