import 'package:drift/drift.dart';
import 'package:finman/core/database/app_database.dart';

class CategoryRepository {
  final AppDatabase _database;

  CategoryRepository(this._database);

  Future<int> addCategory(CategoriesCompanion category) {
    return _database.addCategory(category);
  }

  Future<List<Category>> getCategories() {
    return _database.getCategories();
  }

  Future<int> updateCategory(
    int id,
    CategoriesCompanion category,
  ) {
    final updated = category.copyWith(
      updatedAt: Value(DateTime.now()),
    );

    return _database.updateCategory(id, updated);
  }

  Future<int> deleteCategory(int id) {
    return _database.deleteCategory(id);
  }
}
