import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Color.fromARGB(180, 37, 36, 41),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.search,
            size: 30,
          ),
          VerticalDivider(
            color: Colors.white,
            thickness: 5,
            width: 20,
            indent: 20,
            endIndent: 0,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search note title",
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: () => controller.ChangeViewType(),
            icon: Obx(
              () => Icon(
                controller.isGrid.value ? Icons.grid_view : Icons.list,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
