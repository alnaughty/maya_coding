extension CurrencyFormat on num {
  String toAmount({String currency = "₱", bool isObscured = false}) {
    try {
      String amount = toStringAsFixed(2).replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      );
      if (isObscured) {
        amount = amount.replaceAll(RegExp(r'\d'), '*');
      }
      return "$currency$amount";
    } catch (e) {
      return toString();
    }
  }
}
