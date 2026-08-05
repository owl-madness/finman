import 'dart:async';

import 'package:finman/features/dashboard/providers/dashboard_provider.dart';
import 'package:finman/features/transactions/models/transaction_model.dart';
import 'package:finman/features/transactions/providers/transaction_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final transactionProvider =
    AsyncNotifierProvider<TransactionNotifier, List<TransactionModel>>(
  TransactionNotifier.new,
);

class TransactionNotifier extends AsyncNotifier<List<TransactionModel>> {
  @override
  FutureOr<List<TransactionModel>> build() {
    return ref.watch(transactionRepositoryProvider).getTransactions();
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    await ref.read(transactionRepositoryProvider).addTransaction(transaction);
    ref.invalidateSelf();
    ref.invalidate(dashboardProvider);
  }

  Future<void> updateTransaction(TransactionModel transaction) async {
    await ref
        .read(transactionRepositoryProvider)
        .updateTransaction(transaction);
    ref.invalidateSelf();
    ref.invalidate(dashboardProvider);
  }

  Future<void> deleteTransaction(int id) async {
    await ref.read(transactionRepositoryProvider).deleteTransaction(id);
    ref.invalidateSelf();
    ref.invalidate(dashboardProvider);
  }
}
