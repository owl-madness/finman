import 'package:drift/drift.dart';
import 'package:finman/core/database/converters/transaction_type_converter.dart';
import 'package:finman/core/database/tables/categories.dart';
import 'package:finman/core/database/tables/transactions.dart';
import 'package:finman/features/categories/constants/default_categories.dart';
import 'package:finman/features/transactions/transaction_type.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Categories, Transactions])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _seedDefaultCategories();
        },
      );

  Future<void> _seedDefaultCategories() async {
    await batch(
      (batch) {
        batch.insertAll(
          categories,
          defaultCategories.map(
            (category) => CategoriesCompanion.insert(
              name: category.name,
              type: category.type,
              icon: category.icon,
              color: category.color,
              isSystem: Value(category.isSystem),
            ),
          ),
        );
      },
    );
  }

  // Categories
  Future<int> addCategory(CategoriesCompanion category) {
    return into(categories).insert(category);
  }

  Future<List<Category>> getCategories() {
    return select(categories).get();
  }

  Future<List<Category>> getUserCategories() {
    return (select(categories)..where((tbl) => tbl.isSystem.equals(false)))
        .get();
  }

  Future<Category> getSystemCategory(TransactionType type) {
    return (select(categories)
          ..where((tbl) => tbl.isSystem.equals(true))
          ..where((tbl) => tbl.type.equalsValue(type)))
        .getSingle();
  }

  Future<int> updateCategory(int id, CategoriesCompanion category) {
    return (update(
      categories,
    )..where((tbl) => tbl.id.equals(id)))
        .write(category);
  }

  Future<int> deleteCategory(int id) {
    return (delete(categories)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<int> addTransaction(TransactionsCompanion transaction) {
    return into(transactions).insert(transaction);
  }

  Future<List<Transaction>> getTransactions() {
    return select(transactions).get();
  }

  Future<int> updateTransaction(int id, TransactionsCompanion transaction) {
    return (update(
      transactions,
    )..where((tbl) => tbl.id.equals(id)))
        .write(transaction);
  }

  Future<int> deleteTransaction(int id) {
    return (delete(transactions)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<List<TypedResult>> getTransactionsWithCategory() {
    return _transactionWithCategoryQuery().get();
  }

  Future<int> updateTransactionsCategory({
    required int fromCategoryId,
    required int toCategoryId,
  }) {
    return (update(transactions)
          ..where((tbl) => tbl.categoryId.equals(fromCategoryId)))
        .write(
      TransactionsCompanion(
        categoryId: Value(toCategoryId),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> deleteCategoryAndReassignTransactions({
    required Category category,
  }) async {
    await transaction(() async {
      final systemCategory = await getSystemCategory(category.type);

      await updateTransactionsCategory(
        fromCategoryId: category.id,
        toCategoryId: systemCategory.id,
      );

      await deleteCategory(category.id);
    });
  }

  // Dashboard
  JoinedSelectStatement<HasResultSet, dynamic> _transactionWithCategoryQuery() {
    return select(transactions).join([
      innerJoin(categories, categories.id.equalsExp(transactions.categoryId)),
    ]);
  }

  Future<int> getTotalIncome() async {
    final query = _transactionWithCategoryQuery()
      ..where(categories.type.equalsValue(TransactionType.income));
    final rows = await query.get();
    return rows.fold<int>(
      0,
      (sum, row) => sum + row.readTable(transactions).amount,
    );
  }

  Future<int> getTotalExpense() async {
    final query = _transactionWithCategoryQuery()
      ..where(categories.type.equalsValue(TransactionType.expense));
    final rows = await query.get();
    return rows.fold<int>(
      0,
      (sum, row) => sum + row.readTable(transactions).amount,
    );
  }

  Future<List<TypedResult>> getRecentTransactions({int limit = 5}) {
    final query = _transactionWithCategoryQuery()
      ..orderBy([
        OrderingTerm.desc(transactions.transactionDate),
      ])
      ..limit(limit);
    return query.get();
  }
}
