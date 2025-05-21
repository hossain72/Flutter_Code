import 'dart:convert';
import 'package:characters/characters.dart';

extension StringExtension on String {
  /// Capitalizes the first letter of the string.
  ///
  /// Input:
  /// "hello".capitalize()
  /// Output:
  /// "Hello"
  String get capitalize {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  /// Checks if the string contains [value], case-insensitively.
  ///
  /// Input:
  /// "Hello World".containsIgnoreCase("world")
  /// Output:
  /// true
  bool containsIgnoreCase(String value) =>
      toLowerCase().contains(value.toLowerCase());

  /// Generates initials from the string (typically a full name).
  ///
  /// Input:
  /// "John Doe".initials
  /// "Alice".initials
  /// Output:
  /// "JD"
  /// "AL"
  String get initials {
    if (isEmpty) return '';
    final words = trim().split(RegExp(r'\s+'));
    if (words.isEmpty) return '';
    if (words.length == 1) {
      return words.first.characters.take(2).toUpperCase().toString();
    } else {
      return '${words.first.characters.first.toUpperCase()}${words[1].characters.first.toUpperCase()}';
    }
  }

  /// Checks if the string is a valid email address.
  ///
  /// Input:
  /// "example@gmail.com".isValidEmail
  /// Output:
  /// true
  bool get isValidEmail {
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegExp.hasMatch(this);
  }

  /// Removes all whitespace characters from the string.
  ///
  /// Input:
  /// "  hello world  ".removeAllWhitespace
  /// Output:
  /// "helloworld"
  String get removeAllWhitespace => replaceAll(RegExp(r'\s+'), '');

  /// Attempts to convert the string to an [int].
  ///
  /// Input:
  /// "123".toIntOrNull()
  /// Output:
  /// 123
  int? toIntOrNull() => int.tryParse(this);

  /// Attempts to convert the string to a [double].
  ///
  /// Input:
  /// "3.14".toDoubleOrNull()
  /// Output:
  /// 3.14
  double? toDoubleOrNull() => double.tryParse(this);

  /// Converts the string to title case.
  ///
  /// Input:
  /// "hello world".toTitleCase()
  /// Output:
  /// "Hello World"
  String toTitleCase() => split(' ').map((word) => word.capitalize).join(' ');

  /// Checks if the string contains only numeric characters.
  ///
  /// Input:
  /// "123456".isNumeric()
  /// Output:
  /// true
  bool isNumeric() => RegExp(r'^\d+$').hasMatch(this);

  /// Encodes the string to Base64.
  ///
  /// Input:
  /// "hello".toBase64()
  /// Output:
  /// "aGVsbG8="
  String toBase64() => base64Encode(utf8.encode(this));

  /// Decodes the string from Base64.
  ///
  /// Input:
  /// "aGVsbG8=".fromBase64()
  /// Output:
  /// "hello"
  String fromBase64() => utf8.decode(base64Decode(this));

  /// Reverses the string.
  ///
  /// Input:
  /// "Flutter".reverse
  /// Output:
  /// "rettulF"
  String get reverse => characters.toList().reversed.join();

  /// Converts the string to camelCase.
  ///
  /// Input:
  /// "hello world".toCamelCase()
  /// "hello_world".toCamelCase()
  /// Output:
  /// "helloWorld"
  /// "helloWorld"
  String toCamelCase() {
    if (isEmpty) return '';
    final words = split(RegExp(r'[_\-\s]+'));
    return words.asMap().entries.map((entry) {
      final index = entry.key;
      final word = entry.value;
      return index == 0 ? word.toLowerCase() : word.capitalize;
    }).join();
  }

  /// Converts the string to snake_case.
  ///
  /// Input:
  /// "helloWorld".toSnakeCase()
  /// Output:
  /// "hello_world"
  String toSnakeCase() {
    return replaceAllMapped(RegExp(r'([A-Z])'), (Match match) {
      return '_${match.group(0)!.toLowerCase()}';
    }).toLowerCase();
  }

  /// Removes all special characters from the string.
  ///
  /// Input:
  /// "He@llo, W#orld!".trimSpecialCharacters()
  /// Output:
  /// "Hello World"
  String trimSpecialCharacters() => replaceAll(RegExp(r'[^a-zA-Z0-9 ]'), '');

  /// Truncates the string to [maxLength] and appends [ellipsis] if needed.
  ///
  /// Input:
  /// "Hello World".truncate(5)
  /// Output:
  /// "Hello..."
  String truncate(int maxLength, {String ellipsis = '...'}) {
    return length > maxLength ? '${substring(0, maxLength)}$ellipsis' : this;
  }

  /// Checks if the string is a strong password.
  ///
  /// Input:
  /// "P@ssw0rd!".isStrongPassword()
  /// Output:
  /// true
  bool isStrongPassword({
    int minLength = 8,
    bool requireUppercase = true,
    bool requireLowercase = true,
    bool requireNumbers = true,
    bool requireSpecialChars = true,
  }) {
    if (length < minLength) return false;
    if (requireUppercase && !contains(RegExp(r'[A-Z]'))) return false;
    if (requireLowercase && !contains(RegExp(r'[a-z]'))) return false;
    if (requireNumbers && !contains(RegExp(r'[0-9]'))) return false;
    if (requireSpecialChars && !contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return false;
    }
    return true;
  }

  /// Checks if the string is null or empty (safe for nullable strings).
  ///
  /// Input:
  /// "".isNullOrEmpty
  /// "  ".isNullOrEmpty
  /// Output:
  /// true
  bool get isNullOrEmpty => trim().isEmpty;

  /// Get character count including whitespace.
  ///
  /// Input:
  /// "hello world".lengthWithWhitespace
  /// Output:
  /// 11
  int get lengthWithWhitespace => length;

  /// Get character count excluding all whitespace.
  ///
  /// Input:
  /// "hello world".lengthWithoutWhitespace
  /// Output:
  /// 10
  int get lengthWithoutWhitespace => replaceAll(RegExp(r'\s+'), '').length;

  /// Returns the word count of the string.
  ///
  /// Input:
  /// "hello world flutter".getWordCount()
  /// Output:
  /// 3
  int getWordCount() => trim().isEmpty ? 0 : split(RegExp(r'\s+')).length;

  bool get isValidBDPhone {
    final bdPhoneRegExp = RegExp(r'^(?:\+8801|01)[3-9]\d{8}$');
    return bdPhoneRegExp.hasMatch(this);
  }

  String get formattedWithBDCode {
    final trimmed = trim();
    if (trimmed.startsWith('+88')) {
      return trimmed;
    } else if (trimmed.startsWith('01')) {
      return '+88$trimmed';
    } else {
      // Return original if it doesn't look like a BD mobile number
      return trimmed;
    }
  }
}
