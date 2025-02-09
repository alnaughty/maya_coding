extension Parser on String {
  Uri toUri() => Uri.parse(this);
}

extension Validator on String {
  bool get isValidEmail {
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    return emailRegex.hasMatch(this);
  }

  bool isValidMoneyAmount() {
    // return RegExp(r'^(?!0)\d{1,3}(,\d{3})*(\.\d{2})?$').hasMatch(this);
    return RegExp(r'^(?!0)\d+(,\d{3})*(\.\d{1,2})?$').hasMatch(this);
  }
}
