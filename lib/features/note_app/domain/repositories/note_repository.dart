import 'package:dartz/dartz.dart';
import 'package:noteapp/core/errors/failure.dart';
import 'package:noteapp/features/note_app/domain/entities/note_entity.dart';

abstract class NoteRepository {
  Future<Either<Failure, List<NoteEntity>>> getNotes();
  Future<Either<Failure, bool>> insertNote(NoteEntity note);
  Future<Either<Failure, void>> updateNote(NoteEntity note);
  Future<Either<Failure, void>> deleteNote(int id);
}
