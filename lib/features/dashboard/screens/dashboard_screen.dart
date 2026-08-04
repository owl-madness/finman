import 'package:finman/app/router/app_routes.dart';

import 'package:finman/core/utils/string_utils.dart';

import 'package:finman/features/categories/constants/category_icons.dart';

import 'package:finman/features/dashboard/providers/dashboard_provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final dashboardAsync = ref.watch(dashboardProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      body: dashboardAsync.when(
        data: (summary) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Current Balance"),
                    Text(
                      FinmanStringUtils.formatCurrency(summary.balance),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Text(
                          "Expense: ${FinmanStringUtils.formatCurrency(summary.totalExpense)}",
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Text(
                          "Income: ${FinmanStringUtils.formatCurrency(summary.totalIncome)}",
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recent Transactions",
                    ),
                    IconButton(
                        onPressed: () {
// navigate to transactions

                          context.push(AppRoutes.transactions);
                        },
                        icon: Icon(Icons.arrow_forward_ios_sharp))
                  ],
                ),
                ...summary.recentTransactions.map(
                  (e) => ListTile(
                    title: Text(e.title),
                    trailing: Icon(getCategoryIcon(e.category.icon)?.icon),
                  ),
                )
              ],
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
                context.push(AppRoutes.categories);
              },
              child: const Icon(Icons.category),
            ),
            const SizedBox(height: 8),
            FloatingActionButton.small(
              heroTag: "Transaction",
              onPressed: () {
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
