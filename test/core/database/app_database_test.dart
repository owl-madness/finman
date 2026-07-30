import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:finman/core/database/app_database.dart';
import 'package:finman/features/transactions/transaction_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
  });

  test('addCategory should insert a category', () async {
    // arrange
    final now = DateTime.now();
    final category = CategoriesCompanion.insert(
      name: 'Food',
      type: TransactionType.expense,
      icon: 'restaurant',
      color: 0xFFF44336,
      createdAt: Value(now),
      updatedAt: Value(now),
    );

    // act
    int id = await database.addCategory(category);
    final categories = await database.getCategories();

    // assert
    expect(id, greaterThan(0));
    expect(categories.length, 1);
    expect(categories.first.name, 'Food');
    expect(categories.first.type, TransactionType.expense);
    expect(categories.first.icon, 'restaurant');
  });
}
