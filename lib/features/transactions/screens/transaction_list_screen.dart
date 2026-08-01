import 'package:finman/app/router/app_routes.dart';
import 'package:finman/core/utils/date_utils.dart';
import 'package:finman/core/utils/string_utils.dart';
import 'package:finman/features/categories/constants/category_icons.dart';
import 'package:finman/features/transactions/providers/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TransactionListScreen extends ConsumerWidget {
  const TransactionListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionAsync = ref.watch(transactionProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Transactions')),
      body: transactionAsync.when(
        data: (transactions) {
          if (transactions.isEmpty) {
            return Center(child: Text("No transaction yet"));
          }
          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];

              return ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                leading: Icon(
                  getCategoryIcon(transaction.category.icon)?.icon,
                  color: Color(transaction.category.color),
                ),
                title: Text(FinmanStringUtils.capitalise(transaction.title)),
                subtitle: Text(
                  "${transaction.category.name} • ${FinmanDateUtils.formatDate(transaction.transactionDate)}",
                ),
                trailing: Text(
                  FinmanStringUtils.formatCurrency(transaction.amount),
                  // "₹ ${transaction.amount / 100}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
                onTap: () {
                  context.push(AppRoutes.transactionForm, extra: transaction);
                },
              );
            },
          );
        },
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.transactionForm),
        child: Icon(Icons.add),
      ),
    );
  }
}
