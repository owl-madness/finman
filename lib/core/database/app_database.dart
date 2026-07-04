import 'package:drift/drift.dart';
import 'package:finman/core/database/converters/transaction_type_converter.dart';
import 'package:finman/core/database/tables/categories.dart';
import 'package:finman/core/database/tables/transactions.dart';
import 'package:finman/features/transaction/transaction_type.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Categories, Transactions])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override
  int get schemaVersion => 1;

  // Categories
  Future<int> addCategory(CategoriesCompanion category) {
    return into(categories).insert(category);
  }

  Future<List<Category>> getCategories() {
    return select(categories).get();
  }

  Future<int> updateCategory(int id, CategoriesCompanion category) {
    return (update(
      categories,
    )..where((tbl) => tbl.id.equals(id))).write(category);
  }

  Future<int> deleteCategory(int id) {
    return (delete(categories)..where((tbl) => tbl.id.equals(id))).go();
  }
}
