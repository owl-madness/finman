import 'dart:async';

import 'package:drift/drift.dart';
import 'package:finman/core/database/app_database.dart';
import 'package:finman/features/categories/providers/category_repository_provider.dart';
import 'package:finman/features/dashboard/providers/dashboard_provider.dart';
import 'package:finman/features/transactions/providers/transaction_provider.dart';
import 'package:finman/features/transactions/transaction_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoriesProvider =
    AsyncNotifierProvider<CategoriesNotifier, List<Category>>(
  CategoriesNotifier.new,
);

class CategoriesNotifier extends AsyncNotifier<List<Category>> {
  @override
  FutureOr<List<Category>> build() {
    final repository = ref.watch(categoryRepositoryProvider);
    return repository.getUserCategories();
  }

  Future<void> addCategory(
    String name,
    TransactionType type,
    String icon,
    int color, {
    bool? isSystem,
  }) async {
    final repository = ref.read(categoryRepositoryProvider);
    final category = CategoriesCompanion.insert(
      name: name,
      type: type,
      icon: icon,
      color: color,
      isSystem: Value(isSystem ?? false),
    );
    await repository.addCategory(category);
    // state = const AsyncLoading();
    ref.invalidateSelf();
  }

  Future<void> updateCategory(Category category) async {
    final repository = ref.read(categoryRepositoryProvider);
    final updatedCategory = CategoriesCompanion(
      name: Value(category.name),
      type: Value(category.type),
      icon: Value(category.icon),
      color: Value(category.color),
    );
    await repository.updateCategory(category.id, updatedCategory);
    ref.invalidateSelf();
    ref.invalidate(transactionProvider);
    ref.invalidate(dashboardProvider);
  }

  Future<void> deleteCategory(Category category) async {
    await ref.read(categoryRepositoryProvider).deleteCategory(category);

    ref.invalidateSelf();
    ref.invalidate(transactionProvider);
    ref.invalidate(dashboardProvider);
  }
}
