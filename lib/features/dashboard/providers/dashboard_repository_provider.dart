import 'package:finman/core/database/database_provider.dart';
import 'package:finman/features/dashboard/repositories/dashboard_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardRepositoryProvider = Provider<DashboardRepository>(
  (ref) => DashboardRepository(ref.read(appDatabaseProvider)),
);
