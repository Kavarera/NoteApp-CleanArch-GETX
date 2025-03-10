// ignore_for_file: void_checks

import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:noteapp/core/errors/failure.dart';
import 'package:noteapp/features/note_app/data/datasource/note_local_data_source.dart';
import 'package:noteapp/features/note_app/data/models/category_model.dart';
import 'package:noteapp/features/note_app/domain/entities/note_entity.dart';
import '../../domain/repositories/note_repository.dart';
import '../models/note_model.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteLocalDataSource localDataSource;

  NoteRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<NoteEntity>>> getNotes() async {
    try {
      final notes = await localDataSource.getNotes();
      notes.forEach((element) {
        log("[NOTE REPO IMPLEMENTATION] Notes Category : ${element.category?.name}-${element.category?.id}");
      });
      return Right(notes.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> insertNote(NoteEntity note) async {
    try {
      final id = await localDataSource.insertNote(NoteModel(
          id: note.id,
          title: note.title,
          content: note.content,
          category: note.category != null
              ? CategoryModel.fromEntity(note.category!)
              : null));
      return Right(id > 0);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateNote(NoteEntity note) async {
    try {
      log("NE=${note.category?.name} - ${note.category?.id} - ${note.category}",
          name: "NOTE-REPO-IMPL:UPDATE-NOTE");
      NoteModel nm = NoteModel(
          id: note.id,
          title: note.title,
          content: note.content,
          category: note.category != null
              ? CategoryModel.fromEntity(note.category!)
              : null);
      log("${note.category != null}NM=${nm.category?.id} - ${nm.category?.name} - ${nm.category}",
          name: "NOTE-REPO-IMPL:UPDATE-NOTE");
      await localDataSource.updateNote(nm);
      return Right(());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNote(int id) async {
    try {
      await localDataSource.deleteNote(id);
      return Right(());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
