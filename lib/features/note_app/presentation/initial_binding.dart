import 'package:get/get.dart';
import 'package:noteapp/features/note_app/data/datasource/note_local_data_source.dart';
import 'package:noteapp/features/note_app/data/repositories/category_repository_impl.dart';
import 'package:noteapp/features/note_app/data/repositories/note_repository_impl.dart';
import 'package:noteapp/features/note_app/domain/repositories/category_repository.dart';
import 'package:noteapp/features/note_app/domain/repositories/note_repository.dart';
import 'package:noteapp/features/note_app/domain/usecases/get_all_category_usecase.dart';
import 'package:noteapp/features/note_app/domain/usecases/get_all_notes.dart';
import 'package:noteapp/features/note_app/presentation/home/controllers/home_controller.dart';
import 'package:noteapp/features/note_app/presentation/splashscreen/controllers/splashscreen_controller.dart';
import 'package:noteapp/features/note_app/presentation/splashscreen/pages/splashscreen_pages.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    // Local Data Source
    Get.lazyPut<NoteLocalDataSource>(() => NoteLocalDataSource());

    // Repository
    Get.lazyPut<NoteRepository>(
        () => NoteRepositoryImpl(localDataSource: Get.find()));
    Get.lazyPut<CategoryRepository>(
        () => CategoryRepositoryImpl(localDataSource: Get.find()));

    //Use Cases
    Get.lazyPut<GetAllNotesUseCase>(
        () => GetAllNotesUseCase(noteRepository: Get.find()));
    Get.lazyPut<GetAllCategoriesUseCase>(
        () => GetAllCategoriesUseCase(categoryRepository: Get.find()));

    //Controllers
    Get.lazyPut<HomeController>(
        () => HomeController(getAllNotesUseCase: Get.find()));
    Get.lazyPut<SplashScreenController>(() => SplashScreenController());
  }
}
