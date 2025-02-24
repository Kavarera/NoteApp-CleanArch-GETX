import 'package:noteapp/features/note_app/domain/entities/note_entity.dart';

class NoteModel extends NoteEntity {
  NoteModel({required super.id, required super.title, required super.content});

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
    };
  }

  NoteEntity toEntity() {
    return NoteEntity(id: id, title: title, content: content);
  }
}
