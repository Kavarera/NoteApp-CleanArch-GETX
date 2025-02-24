import 'package:dartz/dartz.dart';
import 'package:noteapp/core/errors/failure.dart';
import 'package:noteapp/features/note_app/domain/entities/note_entity.dart';
import 'package:noteapp/features/note_app/domain/repositories/note_repository.dart';

class InsertNoteUseCase {
  final NoteRepository noteRepository;

  InsertNoteUseCase(this.noteRepository);

  Future<Either<Failure, bool>> call(NoteEntity noteEntity) async {
    return await noteRepository.insertNote(noteEntity);
  }
}
