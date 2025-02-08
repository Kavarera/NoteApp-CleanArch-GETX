import 'package:get/get.dart';
import 'package:noteapp/features/note_app/domain/usecases/add_new_category_usecase.dart';
import 'package:noteapp/features/note_app/domain/usecases/get_all_category_usecase.dart';
import 'package:noteapp/features/note_app/domain/usecases/get_all_notes.dart';
import 'package:noteapp/features/note_app/presentation/home/controllers/home_controller.dart';
import 'package:noteapp/features/note_app/presentation/home/pages/home_page.dart';
import 'package:noteapp/features/note_app/presentation/note_detail/controllers/note_detail_controller.dart';
import 'package:noteapp/features/note_app/presentation/note_detail/pages/note_detail_page.dart';
import 'package:noteapp/features/note_app/presentation/routes/app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
      binding: BindingsBuilder(() {
        //Use Cases
        Get.lazyPut<GetAllNotesUseCase>(
          () => GetAllNotesUseCase(
            noteRepository: Get.find(),
          ),
        );
        Get.lazyPut<GetAllCategoriesUseCase>(
          () => GetAllCategoriesUseCase(
            categoryRepository: Get.find(),
          ),
        );
        Get.lazyPut<InsertCategoryUseCase>(
          () => InsertCategoryUseCase(
            categoryRepository: Get.find(),
          ),
        );
        //Controller
        Get.lazyPut(() => HomeController(
              getAllNotesUseCase: Get.find(),
              getAllCategoriesUseCase: Get.find(),
              insertCategoryUseCase: Get.find(),
            ));
      }),
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
