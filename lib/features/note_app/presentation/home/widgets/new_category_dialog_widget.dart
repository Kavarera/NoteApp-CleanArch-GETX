import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewCategoryDialogWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function() onAddCategory;

  const NewCategoryDialogWidget(
      {super.key, required this.controller, required this.onAddCategory});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(137, 37, 37, 37),
          border: Border.all(
            color: const Color.fromARGB(255, 104, 104, 104),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            Text(
              "Add New Category",
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Category Name",
                hintStyle: TextStyle(
                  color: Colors.black,
                ),
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
              ),
              style: TextStyle(
                color: Colors.black,
              ),
              controller: controller,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => onAddCategory(),
              child: Text(
                "Submit",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
