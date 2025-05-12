import 'package:intl/intl.dart' as intl;

/// Extension methods for [DateTime] to provide additional utility functions.
extension DateTimeExtension on DateTime {
  /// Format the date using a custom pattern and optional locale.
  ///
  /// Example:
  /// ```dart
  /// DateTime(2024, 5, 12).format() // '12-05-2024'
  /// DateTime(2024, 5, 12).format(format: 'yyyy/MM/dd') // '2024/05/12'
  /// ```
  String format({String format = 'dd-MM-yyyy', String? locale}) =>
      intl.DateFormat(format, locale).format(this);

  /// Check if the date is today.
  ///
  /// Example:
  /// ```dart
  /// DateTime.now().isToday // true
  /// ```
  bool get isToday => isSameDay(DateTime.now());

  /// Check if the date is tomorrow.
  ///
  /// Example:
  /// ```dart
  /// DateTime.now().add(Duration(days: 1)).isTomorrow // true
  /// ```
  bool get isTomorrow => isSameDay(DateTime.now().add(Duration(days: 1)));

  /// Check if the date is yesterday.
  ///
  /// Example:
  /// ```dart
  /// DateTime.now().subtract(Duration(days: 1)).isYesterday // true
  /// ```
  bool get isYesterday => isSameDay(DateTime.now().subtract(Duration(days: 1)));

  /// Check if two dates are on the same day.
  ///
  /// Example:
  /// ```dart
  /// DateTime(2024, 5, 12).isSameDay(DateTime(2024, 5, 12)) // true
  /// ```
  bool isSameDay(DateTime? other) =>
      year == other?.year && month == other?.month && day == other?.day;

  /// Check if two dates are in the same month.
  ///
  /// Example:
  /// ```dart
  /// DateTime(2024, 5, 12).isSameMonth(DateTime(2024, 5, 1)) // true
  /// ```
  bool isSameMonth(DateTime? other) =>
      year == other?.year && month == other?.month;

  /// Returns a human-readable relative time difference.
  ///
  /// Examples:
  /// ```dart
  /// DateTime.now().subtract(Duration(hours: 2)).timeAgo() // '2 h'
  /// DateTime.now().add(Duration(days: 5)).timeAgo() // 'In 5 d'
  /// ```
  String timeAgo() {
    final now = DateTime.now();
    final difference = now.difference(this);
    return difference.isNegative
        ? _futureTimeString(difference.abs())
        : _pastTimeString(difference);
  }

  String _pastTimeString(Duration difference) {
    if (difference.inSeconds < 60) return 'Just Now';
    if (difference.inMinutes < 60) return '${difference.inMinutes} m';
    if (difference.inHours < 24) return '${difference.inHours} h';
    if (difference.inDays < 7) return '${difference.inDays} d';
    if (difference.inDays < 30) return '${(difference.inDays / 7).floor()} w';
    if (difference.inDays < 365) return '${(difference.inDays / 30).floor()} mo';
    return '${(difference.inDays / 365).floor()} y';
  }

  String _futureTimeString(Duration difference) {
    if (difference.inSeconds < 60) return 'In a moment';
    if (difference.inMinutes < 60) return 'In ${difference.inMinutes} m';
    if (difference.inHours < 24) return 'In ${difference.inHours} h';
    if (difference.inDays < 7) return 'In ${difference.inDays} d';
    if (difference.inDays < 30) return 'In ${(difference.inDays / 7).floor()} w';
    if (difference.inDays < 365) return 'In ${(difference.inDays / 30).floor()} mo';
    return 'In ${(difference.inDays / 365).floor()} y';
  }

  /// Returns the start of the day (00:00:00).
  ///
  /// Example:
  /// ```dart
  /// DateTime(2024, 5, 12, 15).startOfDay // 2024-05-12 00:00:00.000
  /// ```
  DateTime get startOfDay => DateTime(year, month, day);

  /// Returns the end of the day (23:59:59.999).
  ///
  /// Example:
  /// ```dart
  /// DateTime(2024, 5, 12).endOfDay // 2024-05-12 23:59:59.999
  /// ```
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  /// Check if the date is in the past.
  ///
  /// Example:
  /// ```dart
  /// DateTime(2000, 1, 1).isPast // true
  /// ```
  bool get isPast => isBefore(DateTime.now());

  /// Check if the date is in the future.
  ///
  /// Example:
  /// ```dart
  /// DateTime.now().add(Duration(days: 1)).isFuture // true
  /// ```
  bool get isFuture => isAfter(DateTime.now());

  /// Returns age in years from this date to now.
  ///
  /// Example:
  /// ```dart
  /// DateTime(2000, 5, 12).age // 24 (as of 2024)
  /// ```
  int get age {
    final now = DateTime.now();
    int age = now.year - year;
    if (now.month < month || (now.month == month && now.day < day)) {
      age--;
    }
    return age;
  }

  /// Returns the name of the day (e.g., Monday).
  ///
  /// Example:
  /// ```dart
  /// DateTime(2024, 5, 12).dayName() // 'Sunday'
  /// ```
  String dayName({String? locale}) =>
      intl.DateFormat('EEEE', locale).format(this);

  /// Returns the full month name (e.g., January).
  ///
  /// Example:
  /// ```dart
  /// DateTime(2024, 5, 12).monthName() // 'May'
  /// ```
  String monthName({String? locale}) =>
      intl.DateFormat('MMMM', locale).format(this);

  /// Create a copy of the DateTime with selectively overridden values.
  ///
  /// Example:
  /// ```dart
  /// DateTime(2024, 5, 12).copyWith(day: 20) // 2024-05-20
  /// ```
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }
}
