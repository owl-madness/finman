import 'package:finman/features/transactions/transaction_type.dart';

class DefaultCategory {
  final String name;
  final TransactionType type;
  final String icon;
  final int color;
  final bool isSystem;

  const DefaultCategory({
    required this.name,
    required this.type,
    required this.icon,
    required this.color,
    this.isSystem = false,
  });
}
