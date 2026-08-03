class Validators {
  const Validators._();

  static String? required(
    String? value, {
    String fieldName = 'This field',
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    return null;
  }

  static String? amount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Amount is required';
    }

    final amount = int.tryParse(value);

    if (amount == null || amount <= 0) {
      return 'Enter a valid amount';
    }

    return null;
  }
}
