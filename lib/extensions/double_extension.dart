import 'dart:math';
import 'package:intl/intl.dart';

extension DoubleExtension on double {
  /// Rounds the double to the specified number of decimal places.
  ///
  /// Input:
  /// 3.14159.roundToDecimalPlaces(2)
  /// Output:
  /// 3.14
  double roundToDecimalPlaces(int places) {
    double mod = pow(10.0, places) as double;
    return ((this * mod).round().toDouble() / mod);
  }

  /// Formats the double as a percentage string with optional decimal places.
  ///
  /// Input:
  /// 0.12345.toPercentage()
  /// 0.12345.toPercentage(decimalPlaces: 2)
  /// Output:
  /// "12%"
  /// "12.35%"
  String toPercentage({int decimalPlaces = 0}) {
    return '${(this * 100).roundToDecimalPlaces(decimalPlaces)}%';
  }

  /// Formats the double as currency with an optional symbol and decimal digits.
  ///
  /// Input:
  /// 1234.56.toCurrency()
  /// 1234.56.toCurrency(symbol: '€', decimalDigits: 1)
  /// Output:
  /// "$1,234.56"
  /// "€1,234.6"
  String toCurrency({String symbol = '\$', int decimalDigits = 2}) {
    return NumberFormat.currency(
      symbol: symbol,
      decimalDigits: decimalDigits,
    ).format(this);
  }

  /// Returns true if the double is a negative number.
  ///
  /// Input:
  /// (-5.0).isNegative
  /// Output:
  /// true
  bool get isNegative => this < 0;

  /// Returns true if the double is a positive number.
  ///
  /// Input:
  /// 3.14.isPositive
  /// Output:
  /// true
  bool get isPositive => this > 0;

  /// Returns true if the double is zero.
  ///
  /// Input:
  /// 0.0.isZero
  /// Output:
  /// true
  bool get isZero => this == 0.0;

  /// Clamps the double between [min] and [max].
  ///
  /// Input:
  /// 12.5.clampTo(0, 10)
  /// Output:
  /// 10.0
  double clampTo(double min, double max) =>
      this < min ? min : (this > max ? max : this);

  /// Converts the double to a fixed-length string with optional trailing zeros.
  ///
  /// Input:
  /// 3.1.toFixedLength(3)
  /// Output:
  /// "3.100"
  String toFixedLength(int decimals) => toStringAsFixed(decimals);

  /// Converts double to a string and trims unnecessary trailing zeros.
  ///
  /// Input:
  /// 3.1400.trimTrailingZeros()
  /// Output:
  /// "3.14"
  String trimTrailingZeros() {
    String result = toStringAsFixed(10);
    result = result.replaceFirst(RegExp(r'\.?0+$'), '');
    return result;
  }
}
