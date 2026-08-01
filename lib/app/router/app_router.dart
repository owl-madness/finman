import 'package:finman/app/router/app_routes.dart';
import 'package:finman/core/database/app_database.dart';
import 'package:finman/features/categories/screens/category_form_screen.dart';
import 'package:finman/features/categories/screens/category_list_screen.dart';
import 'package:finman/features/dashboard/dashboard_screen.dart';
import 'package:finman/features/transactions/models/transaction_model.dart';
import 'package:finman/features/transactions/screens/transaction_form_screen.dart';
import 'package:finman/features/transactions/screens/transaction_list_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutes.dashboard,
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: AppRoutes.transactions,
      builder: (context, state) => const TransactionListScreen(),
    ),
    GoRoute(
      path: AppRoutes.transactionForm,
      builder: (context, state) => TransactionFormScreen(
        transactionModel: state.extra as TransactionModel?,
      ),
    ),
    GoRoute(
      path: AppRoutes.categories,
      builder: (context, state) => const CategoryListScreen(),
    ),
    GoRoute(
      path: AppRoutes.categoryForm,
      builder: (context, state) =>
          CategoryFormScreen(category: state.extra as Category?),
    ),
  ],
);
