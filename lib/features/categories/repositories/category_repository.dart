import 'package:drift/drift.dart';
import 'package:finman/core/database/app_database.dart';

class CategoryRepository {
  final AppDatabase database;

  CategoryRepository(this.database);

  Future<int> addCategory(CategoriesCompanion category) {
    return database.addCategory(category);
  }

  Future<List<Category>> getCategories() {
    return database.getCategories();
  }

  Future<int> updateCategory(
    int id,
    CategoriesCompanion category,
  ) {
    final updated = category.copyWith(
      updatedAt: Value(DateTime.now()),
    );

    return database.updateCategory(id, updated);
  }

  Future<int> deleteCategory(int id) {
    return database.deleteCategory(id);
  }
}
