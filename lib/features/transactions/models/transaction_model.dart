import 'package:finman/core/database/app_database.dart';

class TransactionModel {
  final int? id;
  final int amount;
  final String title;
  final String? note;
  final DateTime transactionDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Category category;

  const TransactionModel({
    this.id,
    required this.amount,
    required this.title,
    this.note,
    required this.transactionDate,
    this.createdAt,
    this.updatedAt,
    required this.category,
  });

  const TransactionModel.create({
    required this.amount,
    required this.title,
    this.note,
    required this.transactionDate,
    required this.category,
  }) : id = null,
       createdAt = null,
       updatedAt = null;

  TransactionModel copyWith({
    int? id,
    int? amount,
    String? title,
    String? note,
    DateTime? transactionDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    Category? category,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      title: title ?? this.title,
      note: note ?? this.note,
      transactionDate: transactionDate ?? this.transactionDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      category: category ?? this.category,
    );
  }
}
