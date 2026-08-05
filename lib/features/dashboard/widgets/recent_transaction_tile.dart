import 'package:finman/core/utils/currency_utils.dart';
import 'package:finman/core/utils/date_utils.dart' as core;
import 'package:finman/features/categories/constants/category_icons.dart';
import 'package:finman/features/transactions/models/transaction_model.dart';
import 'package:finman/features/transactions/transaction_type.dart';
import 'package:flutter/material.dart';

class RecentTransactionTile extends StatelessWidget {
  const RecentTransactionTile(
      {super.key, required this.transaction, this.onTap});
  final TransactionModel transaction;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        child: Icon(
          getCategoryIcon(transaction.category.icon)?.icon,
        ),
      ),
      title: Text(
        transaction.title,
        style: Theme.of(context).textTheme.titleMedium,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        core.DateUtils.formatShortDate(transaction.transactionDate),
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: Text(
        CurrencyUtils.format(transaction.amount),
        textAlign: TextAlign.end,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: transaction.category.type == TransactionType.income
                  ? Colors.green
                  : Colors.red,
            ),
      ),
    );
  }
}
