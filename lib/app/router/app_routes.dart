abstract final class AppRoutes {
  static const dashboard = '/';
  static const transactions = '/transactions';
  static const transactionForm = '/transactions/add';

  static const categories = '/categories';
  static const categoryForm = '/categories/add';

  // remove this function as growing
  static List<String> tempRouteList() => [
    // dashboard,
    transactions,
    transactionForm,
    categories,
    categoryForm,
  ];
}
