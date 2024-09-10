class Regex {
  // static final userName = RegExp(r'^(?![_-]).[A-Za-z0-9_-]((?!_-|-_).)(?<![-_]){3,9}$');
  // static final userName = RegExp(r'^(?=.{8,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$');
  static final userName = RegExp("[a-zA-Z0-9_.-]");

  // static final email = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
  static final email = RegExp(r'^([\w-]|(?<!\.)\.)+[a-zA-Z0-9]@[a-zA-Z0-9]([\w\-]+)((\.([a-zA-Z]){2,9})+)$');

  // static final password = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$'); // Allow Selected Special Characters
  static final password = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[#$^+=!*()@%&]).{8,}$'); //

  static final onlyCharacter = RegExp("[a-zA-Z ]");

  static final alphaNumeric = RegExp("[a-zA-Z0-9]");

  static final onlyDigits = RegExp("[0-9]");

  static final onlyDigitsWithDot = RegExp("[0-9.]");
}