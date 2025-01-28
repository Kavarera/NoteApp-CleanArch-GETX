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
            Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
              height: MediaQuery.of(context).size.height * 0.1,
              color: Colors.red,
              child: Obx(() => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.categories.length,
                    itemBuilder: (context, index) {
                      var c = controller.categories.elementAt(index);
                      if (c.id == -1) {
                        return ElevatedButton(
                            onPressed: () {}, child: Text(c.name));
                      }
                    },
                  )),
            ),
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
