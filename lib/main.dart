import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:noteapp/core/configurations/custom_theme.dart';
import 'package:noteapp/features/note_app/presentation/routes/app_pages.dart';
import 'package:noteapp/features/note_app/presentation/routes/initial_binding.dart';
import 'package:noteapp/features/note_app/presentation/splashscreen/pages/splashscreen_pages.dart';

void main() async {
  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      initialBinding: InitialBinding(),
      getPages: AppPages.pages,
      theme: CustomTheme.darkTheme,
    );
  }
}
