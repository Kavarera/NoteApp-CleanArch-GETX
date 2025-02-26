import 'package:dartz/dartz.dart';
import 'package:noteapp/core/errors/failure.dart';
import 'package:noteapp/features/note_app/domain/entities/note_entity.dart';

import '../repositories/note_repository.dart';

class UpdateNoteUsecase {
  final NoteRepository noteRepository;

  UpdateNoteUsecase({required this.noteRepository});

  Future<Either<Failure, void>> call(NoteEntity note) async {
    return await noteRepository.updateNote(note);
  }
}
