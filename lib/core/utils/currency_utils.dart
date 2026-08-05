class CurrencyUtils {
  CurrencyUtils._();

  static const String _currencySymbol = '₹';

  static String format(int amountInMinorUnits) {
    return '$_currencySymbol ${(amountInMinorUnits / 100).toStringAsFixed(2)}';
  }
}
