import 'package:finman/core/database/app_database.dart';
import 'package:finman/features/categories/screens/category_form_screen.dart';
import 'package:finman/features/categories/screens/category_list_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const CategoryListScreen()),
    GoRoute(
      path: CategoryFormScreen.routePath,
      builder: (context, state) => CategoryFormScreen(
        category: state.extra as Category?,
      ),
    ),
  ],
);
