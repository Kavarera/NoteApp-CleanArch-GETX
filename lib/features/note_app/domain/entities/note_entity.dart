import 'package:noteapp/features/note_app/domain/entities/category_entity.dart';

class NoteEntity {
  final int id;
  final String title;
  final String content;
  final CategoryEntity? category;

  NoteEntity(
      {required this.id,
      required this.title,
      required this.content,
      this.category});
}
