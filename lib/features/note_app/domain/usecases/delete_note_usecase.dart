import 'package:dartz/dartz.dart';
import 'package:noteapp/core/errors/failure.dart';

import '../repositories/note_repository.dart';

class DeleteNoteUsecase {
  final NoteRepository noteRepository;

  DeleteNoteUsecase({required this.noteRepository});

  Future<Either<Failure, void>> call(int idNote) async {
    return await noteRepository.deleteNote(idNote);
  }
}
