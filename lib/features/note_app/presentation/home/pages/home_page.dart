import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../widgets/custom_app_bar_widget.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.log("HomePage Rendered");
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.newNote(),
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
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
              child: Obx(() => ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(width: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.categories.length,
                    itemBuilder: (context, index) {
                      var c = controller.categories.elementAt(index);
                      if (c.id == -1) {
                        return ElevatedButton(
                          onPressed: () {
                            controller.addCategory();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(color: Colors.white),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              Text(
                                c.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return ElevatedButton(
                          onPressed: () {
                            controller.addCategory();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(color: Colors.white),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 30,
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                c.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  )),
            ),
            Expanded(
              child: Obx(
                () {
                  if (controller.notes.isEmpty) {
                    return Center(
                      child: Text(
                        "No Notes",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
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
          ],
        ),
      ),
    );
  }
}
