import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splashscreen_controller.dart';

class SplashScreen extends GetView<SplashScreenController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() {
          if (controller.isDataLoaded.value) {
            return Container();
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(height: 20),
                Text("Mengunduh Data..."),
              ],
            );
          }
        }),
      ),
    );
  }
}
