import 'package:finman/app/router/app_routes.dart';

import 'package:finman/features/dashboard/providers/dashboard_provider.dart';
import 'package:finman/features/dashboard/widgets/balance_card.dart';
import 'package:finman/features/dashboard/widgets/empty_transactions.dart';
import 'package:finman/features/dashboard/widgets/recent_transaction_tile.dart';
import 'package:finman/features/dashboard/widgets/summary_card.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardScreen();
}

class _DashboardScreen extends ConsumerState<DashboardScreen> {
  bool isFabOpen = false;

  void _closeFab() {
    if (!isFabOpen) return;

    setState(() {
      isFabOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dashboardAsync = ref.watch(dashboardProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      body: dashboardAsync.when(
        data: (summary) {
          return RefreshIndicator(
            onRefresh: () async =>
                ref.read(dashboardProvider.notifier).refresh(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  BalanceCard(balance: summary.balance),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: SummaryCard(
                          title: "Income",
                          amount: summary.totalIncome,
                          icon: Icons.arrow_upward_outlined,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SummaryCard(
                          title: "Expense",
                          amount: summary.totalExpense,
                          icon: Icons.arrow_downward_outlined,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Transactions',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      TextButton.icon(
                        onPressed: () {
                          context.push(AppRoutes.transactions);
                        },
                        label: const Text('View all'),
                        icon: const Icon(Icons.arrow_forward, size: 16),
                      ),
                    ],
                  ),
                  summary.recentTransactions.isEmpty
                      ? const EmptyTransactions()
                      : Column(
                          children: [
                            ...summary.recentTransactions.map(
                              (transaction) => RecentTransactionTile(
                                transaction: transaction,
                              ),
                            ),
                          ],
                        ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          );
        },
        error: (error, stackTrace) => Center(
          child: SelectableText(error.toString(), textAlign: TextAlign.center),
        ),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isFabOpen) ...[
            FloatingActionButton.small(
              heroTag: "Category",
              onPressed: () {
                _closeFab();
                context.push(AppRoutes.categories);
              },
              child: const Icon(Icons.category),
            ),
            const SizedBox(height: 8),
            FloatingActionButton.small(
              heroTag: "Transaction",
              onPressed: () {
                _closeFab();
                context.push(AppRoutes.transactions);
              },
              child: const Icon(Icons.payment),
            ),
            const SizedBox(height: 8),
          ],
          FloatingActionButton(
            onPressed: () {
              setState(() {
                isFabOpen = !isFabOpen;
              });
            },
            child: Icon(isFabOpen ? Icons.close : Icons.add),
          ),
        ],
      ),
    );
  }
}
