import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/local/models/category.dart';
import '../data/local/repositories/category_repository.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepository _categoryRepository;

  CategoryCubit()
      : _categoryRepository = CategoryRepository(),
        super(CategoryLoading());

  Future<void> getAllCategorys() async {
    try {
      emit(CategoryLoading());
      final categories = await _categoryRepository.getAll();
      emit(CategoryLoaded(categories: categories));
    } catch (e) {
      emit(CategoryError(errorMessage: e.toString()));
    }
  }

  Future<void> addCategory(Category category) async {
    try {
      await _categoryRepository.addCategory(category);
      emit(CategoryAdded());
    } catch (e) {
      emit(CategoryError(errorMessage: e.toString()));
    }
  }

  Future<void> updateCategory(Category food) async {
    try {
      await _categoryRepository.updateCategory(food);
      emit(CategoryUpdated());
    } catch (e) {
      emit(CategoryError(errorMessage: e.toString()));
    }
  }
}
