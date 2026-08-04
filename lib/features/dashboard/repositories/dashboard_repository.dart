import 'package:finman/core/database/app_database.dart';
import 'package:finman/features/dashboard/models/dashboard_summary.dart';
import 'package:finman/features/transactions/models/transaction_model.dart';

class DashboardRepository {
  final AppDatabase _database;

  DashboardRepository(this._database);

  Future<int> getTotalIncome() {
    return _database.getTotalIncome();
  }

  Future<int> getTotalExpense() {
    return _database.getTotalExpense();
  }

  Future<List<TransactionModel>> getRecentTransactions({int limit = 5}) async {
    final transactionWithCategory =
        await _database.getRecentTransactions(limit: limit);
    return transactionWithCategory.map(
      (e) {
        final transactionRow = e.readTable(_database.transactions);
        final categoryRow = e.readTable(_database.categories);
        return TransactionModel(
          id: transactionRow.id,
          amount: transactionRow.amount,
          title: transactionRow.title,
          transactionDate: transactionRow.transactionDate,
          note: transactionRow.note,
          createdAt: transactionRow.createdAt,
          updatedAt: transactionRow.updatedAt,
          category: categoryRow,
        );
      },
    ).toList();
  }

  Future<DashboardSummary> getDashboardSummary({int limit = 5}) async {
    final result = await Future.wait([
      getTotalIncome(),
      getTotalExpense(),
      getRecentTransactions(limit: limit),
    ]);
    return DashboardSummary(
      totalIncome: result[0] as int,
      totalExpense: result[1] as int,
      recentTransactions: result[2] as List<TransactionModel>,
    );
  }
}
