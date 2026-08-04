import 'package:finman/features/transactions/models/transaction_model.dart';

class DashboardSummary {
  const DashboardSummary({
    required this.totalIncome,
    required this.totalExpense,
    required this.recentTransactions,
  });

  final int totalIncome;
  final int totalExpense;
  final List<TransactionModel> recentTransactions;

  int get balance => totalIncome - totalExpense;
}
