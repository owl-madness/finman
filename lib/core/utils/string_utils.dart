class FinmanStringUtils {
  FinmanStringUtils._();

  static String capitalise(String text) {
    if (text.isEmpty) return text;

    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  static String capitaliseEveryWord(String text) {
    return text
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }

  static String formatCurrency(int amountInPaise) {
    final rupees = amountInPaise / 100;

    if (rupees == rupees.toInt()) {
      return "₹ ${rupees.toInt()}";
    }

    return "₹ ${rupees.toStringAsFixed(2)}";
  }
}
