import 'package:drift/drift.dart';
import 'package:finman/core/database/converters/transaction_type_converter.dart';

class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get type => text().map(transactionTypeConverter)();
  TextColumn get icon => text()();
  IntColumn get color =>
      integer()(); // Stores ARGB color value (e.g. 0xFF2196F3)
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
