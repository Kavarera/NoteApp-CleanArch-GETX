import 'package:get/get.dart';
import 'package:noteapp/features/note_app/presentation/home/pages/home_page.dart';
import 'package:noteapp/features/note_app/presentation/note_detail/controllers/note_detail_controller.dart';
import 'package:noteapp/features/note_app/presentation/note_detail/pages/note_detail_page.dart';
import 'package:noteapp/features/note_app/presentation/routes/initial_binding.dart';
import 'package:noteapp/features/note_app/presentation/routes/app_routes.dart';
import 'package:noteapp/features/note_app/presentation/splashscreen/pages/splashscreen_pages.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splashscreen,
      page: () => SplashScreen(),
      binding: InitialBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
    ),
    GetPage(
      name: AppRoutes.noteDetail,
      page: () => NoteDetailPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => NoteDetailController());
      }),
    )
  ];
}
