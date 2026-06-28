import 'package:drift/drift.dart';
import 'package:finman/core/database/converters/transaction_type_converter.dart';
import 'package:finman/core/database/tables/categories.dart';

class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get amount => integer()();
  IntColumn get categoryId => integer().references(Categories, #id)();
  TextColumn get type => text().map(transactionTypeConverter)();
  TextColumn get title => text()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get transactionDate => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}
