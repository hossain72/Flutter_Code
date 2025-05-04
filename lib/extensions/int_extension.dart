import 'package:intl/intl.dart';

extension IntExtension on int {
  /// Converts the int to a Duration in milliseconds.
  ///
  /// Input:
  /// 500.ms
  /// Output:
  /// Duration(milliseconds: 500)
  Duration get ms => Duration(milliseconds: this);

  /// Converts the int to a Duration in seconds.
  ///
  /// Input:
  /// 5.seconds
  /// Output:
  /// Duration(seconds: 5)
  Duration get seconds => Duration(seconds: this);

  /// Converts the int to a Duration in minutes.
  ///
  /// Input:
  /// 2.minutes
  /// Output:
  /// Duration(minutes: 2)
  Duration get minutes => Duration(minutes: this);

  /// Converts the int to a Duration in hours.
  ///
  /// Input:
  /// 1.hours
  /// Output:
  /// Duration(hours: 1)
  Duration get hours => Duration(hours: this);

  /// Converts the int to a Duration in days.
  ///
  /// Input:
  /// 3.days
  /// Output:
  /// Duration(days: 3)
  Duration get days => Duration(days: this);

  /// Formats the int as currency.
  ///
  /// Input:
  /// 1500.toCurrency(symbol: "₹")
  /// Output:
  /// "₹1,500.00"
  String toCurrency({String symbol = '\$', int decimalDigits = 2}) {
    return NumberFormat.currency(
      symbol: symbol,
      decimalDigits: decimalDigits,
    ).format(this);
  }

  /// Returns true if the number is even.
  ///
  /// Input:
  /// 4.isEven
  /// Output:
  /// true
  bool get isEven => this % 2 == 0;

  /// Returns true if the number is odd.
  ///
  /// Input:
  /// 5.isOdd
  /// Output:
  /// true
  bool get isOdd => this % 2 != 0;

  /// Returns true if the number is a prime number.
  ///
  /// Input:
  /// 7.isPrime
  /// Output:
  /// true
  bool get isPrime {
    if (this <= 1) return false;
    if (this <= 3) return true;
    if (this % 2 == 0 || this % 3 == 0) return false;
    for (int i = 5; i * i <= this; i += 6) {
      if (this % i == 0 || this % (i + 2) == 0) return false;
    }
    return true;
  }

  /// Converts 0 to false and any non-zero number to true.
  ///
  /// Input:
  /// 0.toBool
  /// 1.toBool
  /// Output:
  /// false
  /// true
  bool get toBool => this != 0;

  /// Clamps the number between [min] and [max].
  ///
  /// Input:
  /// 10.clampTo(5, 8)
  /// Output:
  /// 8
  int clampTo(int min, int max) => this < min ? min : (this > max ? max : this);

  /// Returns the percentage value of this number (0–100) relative to [total].
  ///
  /// Input:
  /// 50.percentOf(200)
  /// Output:
  /// 25.0
  double percentOf(num total) {
    if (total == 0) return 0;
    return (this / total) * 100;
  }
}
