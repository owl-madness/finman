import 'package:finman/features/categories/models/default_category.dart';
import 'package:finman/features/transactions/transaction_type.dart';

const defaultCategories = [
  // System
  DefaultCategory(
    name: 'Uncategorized Expense',
    type: TransactionType.expense,
    icon: 'help_outline',
    color: 0xFF9E9E9E, // Grey
    isSystem: true,
  ),

  DefaultCategory(
    name: 'Uncategorized Income',
    type: TransactionType.income,
    icon: 'help_outline',
    color: 0xFF9E9E9E, // Grey
    isSystem: true,
  ),

  // Expense categories
  DefaultCategory(
    name: 'Food',
    type: TransactionType.expense,
    icon: 'restaurant',
    color: 0xFFFF7043, // Deep Orange
  ),

  DefaultCategory(
    name: 'Transport',
    type: TransactionType.expense,
    icon: 'directions_car',
    color: 0xFF42A5F5, // Blue
  ),

  DefaultCategory(
    name: 'Shopping',
    type: TransactionType.expense,
    icon: 'shopping_bag',
    color: 0xFFAB47BC, // Purple
  ),

  DefaultCategory(
    name: 'Bills',
    type: TransactionType.expense,
    icon: 'receipt', // Electricity / Bills
    color: 0xFFEF5350,
  ),

  DefaultCategory(
    name: 'Health',
    type: TransactionType.expense,
    icon: 'medical_services', // Healthcare
    color: 0xFF26A69A,
  ),

  DefaultCategory(
    name: 'Salary',
    type: TransactionType.income,
    icon: 'work', // Salary & Income
    color: 0xFF66BB6A,
  ),

  DefaultCategory(
    name: 'Rent',
    type: TransactionType.expense,
    icon: 'home',
    color: 0xFF8D6E63, // Brown
  ),

  DefaultCategory(
    name: 'Entertainment',
    type: TransactionType.expense,
    icon: 'movie',
    color: 0xFFE91E63, // Pink
  ),

  // DefaultCategory(
  //   name: 'Health',
  //   type: TransactionType.expense,
  //   icon: 'local_hospital',
  //   color: 0xFF26A69A, // Teal
  // ),

  DefaultCategory(
    name: 'Education',
    type: TransactionType.expense,
    icon: 'school',
    color: 0xFF5C6BC0, // Indigo
  ),

  // Income categories
  // DefaultCategory(
  //   name: 'Salary',
  //   type: TransactionType.income,
  //   icon: 'payments',
  //   color: 0xFF66BB6A, // Green
  // ),
];
