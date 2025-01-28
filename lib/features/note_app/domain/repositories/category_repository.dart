import 'package:dartz/dartz.dart';

import '../entities/category_entity.dart';
import '../../../../core/errors/failure.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
  Future<Either<Failure, void>> insertCategory(CategoryEntity note);
  Future<Either<Failure, void>> updateCategory(CategoryEntity note);
  Future<Either<Failure, void>> deleteCategory(int id);
}
