class StringUtils {
  static bool isValidEmail(String text) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(text);
  }

  static bool isNullOrEmpty(String? text) {
    return text == null || text.isEmpty;
  }
}
