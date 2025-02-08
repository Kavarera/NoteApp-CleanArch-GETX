import 'package:get/get.dart';
import 'package:noteapp/features/note_app/data/datasource/note_local_data_source.dart';
import 'package:noteapp/features/note_app/data/repositories/category_repository_impl.dart';
import 'package:noteapp/features/note_app/data/repositories/note_repository_impl.dart';
import 'package:noteapp/features/note_app/domain/repositories/category_repository.dart';
import 'package:noteapp/features/note_app/domain/repositories/note_repository.dart';
import 'package:noteapp/features/note_app/presentation/splashscreen/controllers/splashscreen_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    // Local Data Source
    Get.lazyPut<NoteLocalDataSource>(() => NoteLocalDataSource(), fenix: true);

    // Repository
    Get.lazyPut<NoteRepository>(
      () => NoteRepositoryImpl(
        localDataSource: Get.find(),
      ),
      fenix: true,
    );
    Get.lazyPut<CategoryRepository>(
      () => CategoryRepositoryImpl(
        localDataSource: Get.find(),
      ),
      fenix: true,
    );
    Get.lazyPut<SplashScreenController>(() => SplashScreenController());
  }
}
