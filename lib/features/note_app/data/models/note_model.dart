import 'dart:developer';

import 'package:noteapp/features/note_app/data/models/category_model.dart';
import 'package:noteapp/features/note_app/domain/entities/note_entity.dart';

class NoteModel extends NoteEntity {
  NoteModel(
      {required super.id,
      required super.title,
      required super.content,
      CategoryModel? category})
      : super(category: category);

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      category: json['categoryId'] != null
          ? CategoryModel(
              id: json['categoryId'], name: json['category_name'] ?? '')
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    log(
      "$id-$title-$content-${category?.id}",
      name: "NOTE-MODEL:TOJSON",
      time: DateTime.now(),
    );
    return {
      'title': title,
      'content': content,
      if (category != null) 'categoryId': category?.id,
    };
  }

  NoteEntity toEntity() {
    return NoteEntity(
        id: id, title: title, content: content, category: category);
  }
}
