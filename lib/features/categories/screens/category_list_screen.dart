import 'package:finman/app/router/app_routes.dart';
import 'package:finman/features/categories/constants/category_icons.dart';
import 'package:finman/features/categories/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CategoryListScreen extends ConsumerWidget {
  const CategoryListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryAsync = ref.watch(categoriesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: categoryAsync.when(
        data: (categories) {
          if (categories.isEmpty) {
            return const Center(child: Text('No categories yet'));
          }

          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];

              return ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                leading: Icon(
                  getCategoryIcon(category.icon)?.icon,
                  color: Color(category.color),
                ),
                title: Text(category.name),
                subtitle: Text(category.type.name.toUpperCase()),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  context.push(AppRoutes.categoryForm, extra: category);
                },
              );
            },
          );
        },
        error: (error, stackTrace) => Center(
          child: SelectableText(error.toString(), textAlign: TextAlign.center),
        ),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(AppRoutes.categoryForm);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
