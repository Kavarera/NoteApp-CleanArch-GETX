import 'package:dartz/dartz.dart';
import 'package:noteapp/core/errors/failure.dart';
import 'package:noteapp/features/note_app/data/models/category_model.dart';
import 'package:noteapp/features/note_app/domain/entities/category_entity.dart';
import 'package:noteapp/features/note_app/domain/repositories/category_repository.dart';

import '../datasource/note_local_data_source.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final NoteLocalDataSource localDataSource;

  CategoryRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, void>> deleteCategory(int id) async {
    try {
      await localDataSource.deleteCategory(id);
      return Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final categories = await localDataSource.getCategories();
      return Right(categories);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> insertCategory(CategoryEntity category) async {
    try {
      await localDataSource.insertCategory(
        CategoryModel(id: category.id, name: category.name),
      );
      return Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateCategory(CategoryEntity category) async {
    try {
      await localDataSource.updateCategory(
        CategoryModel(id: category.id, name: category.name),
      );
      return Right(null);
    } catch (e) {
      return left(CacheFailure(e.toString()));
    }
  }
}
