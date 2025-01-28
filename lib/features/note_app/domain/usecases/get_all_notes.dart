import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:noteapp/core/errors/failure.dart';
import 'package:noteapp/features/note_app/domain/entities/note_entity.dart';
import 'package:noteapp/features/note_app/domain/repositories/note_repository.dart';

class GetAllNotesUseCase {
  final NoteRepository noteRepository;

  GetAllNotesUseCase({required this.noteRepository});

  Future<Either<Failure, List<NoteEntity>>> call() async {
    var data = await noteRepository.getNotes();
    log("GEtAllNotesUseCase: ${data.runtimeType.toString()}");
    return await noteRepository.getNotes();
  }
}
