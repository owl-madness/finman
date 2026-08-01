import 'package:drift/drift.dart';
import 'package:finman/core/database/app_database.dart';
import 'package:finman/features/transactions/models/transaction_model.dart';

class TransactionRepository {
  final AppDatabase _database;

  TransactionRepository(this._database);

  Future<List<TransactionModel>> getTransactions() async {
    final result = await _database.getTransactionsWithCategory();
    return result.map((row) {
      final transaction = row.readTable(_database.transactions);
      final category = row.readTable(_database.categories);
      return TransactionModel(
        id: transaction.id,
        amount: transaction.amount,
        title: transaction.title,
        transactionDate: transaction.transactionDate,
        createdAt: transaction.createdAt,
        updatedAt: transaction.updatedAt,
        note: transaction.note,
        category: category,
      );
    }).toList();
  }

  Future<int> addTransaction(TransactionModel transaction) async {
    return _database.addTransaction(
      TransactionsCompanion.insert(
        amount: transaction.amount,
        categoryId: transaction.category.id,
        title: transaction.title,
        note: Value(transaction.note),
        transactionDate: transaction.transactionDate,
      ),
    );
  }

  Future<int> updateTransaction(TransactionModel transaction) async {
    return _database.updateTransaction(
      transaction.id!,
      TransactionsCompanion(
        amount: Value(transaction.amount),
        title: Value(transaction.title),
        note: Value(transaction.note),
        categoryId: Value(transaction.category.id),
        transactionDate: Value(transaction.transactionDate),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<int> deleteTransaction(int id) async {
    return _database.deleteTransaction(id);
  }
}
