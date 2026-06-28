import 'package:drift/drift.dart';
import 'package:finman/core/database/converters/transaction_type_converter.dart';

class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get type => text().map(transactionTypeConverter)();
  TextColumn get icon => text()();
  IntColumn get color => integer()();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}
