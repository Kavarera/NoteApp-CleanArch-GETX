import 'package:dartz/dartz.dart';
import 'package:noteapp/features/note_app/domain/repositories/category_repository.dart';

import '../../../../core/errors/failure.dart';

class DeleteCategoryUsecase {
  final CategoryRepository categoryRepository;

  DeleteCategoryUsecase({required this.categoryRepository});

  Future<Either<Failure, void>> call(int idCategory) async {
    return await categoryRepository.deleteCategory(idCategory);
  }
}
