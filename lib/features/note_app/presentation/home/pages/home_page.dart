import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../widgets/custom_app_bar_widget.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                        if (c.id == -2) {
                          return InkWell(
                            onTap: () {
                              controller.resetNotes();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 5,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                    style: BorderStyle.solid),
                              ),
                              child: Text(c.name),
                            ),
                          );
                        }
                        return Dismissible(
                          key: Key(c.id.toString()),
                          direction: DismissDirection.up,
                          onDismissed: (_) {
                            controller.removeCategory(c.id);
                          },
                          child: InkWell(
                            onTap: () {
                              controller.filterCategories(c.id);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 5,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                    style: BorderStyle.solid),
                              ),
                              child: Text(c.name),
                            ),
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
                    if (controller.isGrid.value) {
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 kolom
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio:
                              0.8, // Ratio standar, nanti diubah per item
                        ),
                        itemCount: controller.notes.length,
                        itemBuilder: (context, index) {
                          final note = controller.notes[index];

                          return Dismissible(
                            key: Key(controller.notes
                                .elementAt(index)
                                .id
                                .toString()),
                            onDismissed: (_) {
                              controller.removeNote(index);
                            },
                            direction: DismissDirection.down,
                            child: GestureDetector(
                              onTap: () => controller.editNote(index),
                              child: Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.primaries[
                                      index % Colors.primaries.length],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(note.category?.name ?? '',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white70)),
                                    SizedBox(height: 8),
                                    Text(note.title,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                    SizedBox(height: 4),
                                    RichText(
                                      text: controller.buildTextSpan(
                                          note.content, context),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 7,
                                    )

                                    // Text(
                                    //   note.content,
                                    //   style: TextStyle(
                                    //       fontSize: 16, color: Colors.white),
                                    //   overflow: TextOverflow.ellipsis,
                                    //   maxLines: 6,
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return ListView.builder(
                        itemCount: controller.notes.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                              onDismissed: (_) {
                                controller.removeNote(index);
                              },
                              direction: DismissDirection.startToEnd,
                              key: Key(controller.notes
                                  .elementAt(index)
                                  .id
                                  .toString()),
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerLeft,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(Icons.delete, color: Colors.white),
                              ),
                              child: ListTile(
                                onTap: () {
                                  controller.editNote(index);
                                },
                                title: Text(controller.notes[index].title),
                                subtitle: Text(
                                    controller.notes[index].category?.name ??
                                        ''),
                              ));
                        },
                      );
                    }
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
