import 'dart:io';

import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';

QueryExecutor openConnection() {
  return LazyDatabase(() async {
    final appDocumentsDir = await getApplicationDocumentsDirectory();
    final path = p.join(appDocumentsDir.path, 'finman.db');
    final file = File(path);

    return NativeDatabase(file);
  });
}
