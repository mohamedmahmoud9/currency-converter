class Validator {
  static String? numbers(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return "Required";
      }
      if (value.startsWith('+')) {
        value = value.replaceFirst(r'+', '');
      }
      final double? number = double.tryParse(value);
      if (number == null) {
        return 'Must be a number';
      }
      if (number < 0) {
        return 'Must be greater than 0';
      }
    }
    return null;
  }
}
