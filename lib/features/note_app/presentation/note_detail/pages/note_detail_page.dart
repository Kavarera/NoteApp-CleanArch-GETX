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
        bottomNavigationBar: Container(
          child: PopupMenuButton(
            elevation: 20,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.white,
            menuPadding: const EdgeInsets.symmetric(vertical: 5),
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
            ),
            position: PopupMenuPosition.over,
            onSelected: (int index) {
              // Tindakan saat opsi dipilih
              controller.changeSelectedCategory(index);
            },
            itemBuilder: (BuildContext context) {
              return controller.categories.map((c) {
                return PopupMenuItem(
                  value: c.id,
                  child: Text(c.name,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .apply(color: Colors.black)),
                );
              }).toList();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Obx(
                () => Row(
                  children: [
                    Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            controller.selectedCategory.value == null
                                ? Text("Select Category")
                                : Text(controller.selectedCategory.value!.name),
                            Icon(Icons.arrow_drop_up),
                          ]),
                    ),
                    SizedBox(width: 20),
                    InkWell(
                        onTap: () {
                          controller.clearSelectedCategory();
                        },
                        child: Icon(Icons.block)),
                  ],
                ),
              ),
            ),
          ),
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
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          controller.applyFormat('b');
                        },
                        icon: Icon(Icons.format_bold),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.applyFormat('i');
                        },
                        icon: Icon(Icons.format_italic),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.applyFormat('u');
                        },
                        icon: Icon(Icons.format_underline),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Flexible(
                  child: SingleChildScrollView(
                    child: Obx(
                      () {
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
                                : SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: RichText(
                                      text: controller.activeContentController
                                          .buildTextSpan(
                                        context: context,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                        withComposing: true,
                                        showTags: false,
                                      ),
                                    ),
                                  ),
                          );
                        }
                      },
                    ),
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
