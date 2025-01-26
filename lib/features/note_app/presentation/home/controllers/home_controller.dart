import 'package:get/get.dart';
import 'package:noteapp/features/note_app/domain/usecases/get_all_notes.dart';

class HomeController extends GetxController {
  final GetAllNotesUseCase getAllNotesUseCase;

  HomeController({required this.getAllNotesUseCase});
}
