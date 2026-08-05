import 'package:drift/drift.dart';
import 'package:finman/core/database/app_database.dart';
import 'package:finman/features/transactions/transaction_type.dart';

class CategoryRepository {
  final AppDatabase _database;

  CategoryRepository(this._database);

  Future<int> addCategory(CategoriesCompanion category) {
    return _database.addCategory(category);
  }

  Future<List<Category>> getCategories() {
    return _database.getCategories();
  }

  Future<List<Category>> getUserCategories() {
    return _database.getUserCategories();
  }

  Future<Category> getSystemCategory(TransactionType type) {
    return _database.getSystemCategory(type);
  }

  Future<int> updateCategory(int id, CategoriesCompanion category) {
    final updated = category.copyWith(updatedAt: Value(DateTime.now()));

    return _database.updateCategory(id, updated);
  }

  Future<void> deleteCategory(Category category) {
    return _database.deleteCategoryAndReassignTransactions(category: category);
  }
}
