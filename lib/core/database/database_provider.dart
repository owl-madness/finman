import 'package:finman/core/database/app_database.dart';
import 'package:finman/core/database/database_connection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase(openConnection());
});
