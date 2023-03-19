import '../database/app_database.dart';
import '../models/category.dart';

class CategoryRepository {
  final categoryDao = AppDatabase.instance.categoryDao;

  Future<List<Category>> getAll() async {
    return await categoryDao.getAll();
  }

  Future<void> addCategory(Category category) async {
    await categoryDao.insert(category);
  }

  Future<void> updateCategory(Category category) async {
    await categoryDao.update(category);
  }

  Future<void> deletecategory(Category category) async {
    await categoryDao.delete(category);
  }
}
