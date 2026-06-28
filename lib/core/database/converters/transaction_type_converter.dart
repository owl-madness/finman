import 'package:drift/drift.dart';
import 'package:finman/features/transaction/transaction_type.dart';

final transactionTypeConverter = TransactionTypeConverter();

class TransactionTypeConverter extends TypeConverter<TransactionType, String> {
  @override
  TransactionType fromSql(String fromDb) {
    return TransactionType.values.byName(fromDb);
  }

  @override
  String toSql(TransactionType value) {
    return value.name;
  }
}
