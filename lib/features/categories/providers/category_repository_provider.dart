import 'package:finman/core/database/database_provider.dart';
import 'package:finman/features/categories/repositories/category_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  final database = ref.read(appDatabaseProvider);
  return CategoryRepository(database);
});
