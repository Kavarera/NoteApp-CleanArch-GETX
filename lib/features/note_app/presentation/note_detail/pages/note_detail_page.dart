import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                  () => SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: controller.isSelection.value
                              ? () {
                                  controller.applyFormat('b');
                                }
                              : null,
                          icon: Icon(Icons.format_bold),
                        ),
                        IconButton(
                          onPressed: controller.isSelection.value
                              ? () {
                                  controller.applyFormat('i');
                                }
                              : null,
                          icon: Icon(Icons.format_italic),
                        ),
                        IconButton(
                          onPressed: controller.isSelection.value
                              ? () {
                                  controller.applyFormat('u');
                                }
                              : null,
                          icon: Icon(Icons.format_underline),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
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
                          child: controller.content!.value.isEmpty
                              ? Text("Tap to add content",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium)
                              : RichText(
                                  text: controller.activeContentController
                                      .buildTextSpan(
                                    context: context,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                    withComposing: true,
                                    showTags: false,
                                  ),
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
