import 'package:finman/core/database/database_provider.dart';
import 'package:finman/features/transactions/repositories/transaction_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  return TransactionRepository(ref.read(appDatabaseProvider));
});
