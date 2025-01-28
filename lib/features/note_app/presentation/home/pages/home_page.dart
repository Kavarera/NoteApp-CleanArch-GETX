import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../widgets/custom_app_bar_widget.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
              child: Container(
                color: Colors.transparent,
              ),
            ),
            //App barr Custom
            CustomAppbar(controller: controller),

            //Category List

            Expanded(
              child: Container(
                child: Obx(
                  () {
                    if (controller.notes.isEmpty) {
                      return Center(
                        child: Text("No Notes"),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: controller.notes.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(controller.notes[index].title),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
