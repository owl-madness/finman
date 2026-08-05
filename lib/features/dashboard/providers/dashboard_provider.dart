import 'dart:async';

import 'package:finman/features/dashboard/models/dashboard_summary.dart';
import 'package:finman/features/dashboard/providers/dashboard_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardProvider =
    AsyncNotifierProvider<DashboardNotifier, DashboardSummary>(
  DashboardNotifier.new,
);

class DashboardNotifier extends AsyncNotifier<DashboardSummary> {
  @override
  FutureOr<DashboardSummary> build() {
    return ref.watch(dashboardRepositoryProvider).getDashboardSummary();
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}
