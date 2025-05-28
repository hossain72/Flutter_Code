import 'dart:io';
import 'package:flutter/foundation.dart';
import 'flavor_config.dart';

class AppLog {
  // ANSI color codes
  static const _reset = '\x1B[0m';
  static const _red = '\x1B[31m';
  static const _green = '\x1B[32m';
  static const _yellow = '\x1B[33m';
  static const _blue = '\x1B[34m';
  static const _brightRed = '\x1B[91m';
  static const _brightGreen = '\x1B[92m';
  static const _brightYellow = '\x1B[93m';
  static const _brightMagenta = '\x1B[95m';
  static const _brightCyan = '\x1B[96m';

  // Unicode box drawing characters
  static const _topLeft = '┌';
  static const _topRight = '┐';
  static const _bottomLeft = '└';
  static const _bottomRight = '┘';
  static const _horizontal = '─';
  static const _vertical = '│';

  // Check if we should use ANSI colors (Android only)
  static bool get _shouldUseANSI {
    if (kIsWeb) return false;
    return Platform.isAndroid;
  }

  static void info(String message) {
    _printLog('🔵', 'ℹ️', message, 'INFO', _brightCyan);
  }

  static void success(String message) {
    _printLog('🟢', '✅', message, 'SUCCESS', _brightGreen);
  }

  static void warning(String message) {
    _printLog('🟡', '⚠️', message, 'WARNING', _brightYellow);
  }

  static void error(String message) {
    _printLog('🔴', '❌', message, 'ERROR', _brightRed);
  }

  static void debug(String message) {
    _printLog('🟣', '🐞', message, 'DEBUG', _brightMagenta);
  }

  // Additional log methods with distinct colors
  static void network(String message) {
    _printLog('🌐', '🔗', message, 'NETWORK', _blue);
  }

  static void database(String message) {
    _printLog('🗄️', '💾', message, 'DATABASE', _green);
  }

  static void performance(String message) {
    _printLog('⚡', '📊', message, 'PERF', _yellow);
  }

  static void security(String message) {
    _printLog('🔒', '🛡️', message, 'SECURITY', _red);
  }

  static void _printLog(
    String bgEmoji,
    String iconEmoji,
    String message,
    String tag,
    String ansiColor,
  ) {
    if (kDebugMode || FlavorConfig.isDEV()) {
      final timestamp = DateTime.now().toString().substring(11, 19);
      _printBoxLog(bgEmoji, iconEmoji, message, tag, timestamp, ansiColor);
    }
  }

  static void _printBoxLog(
    String bgEmoji,
    String iconEmoji,
    String message,
    String tag,
    String timestamp,
    String ansiColor,
  ) {
    // Create content with or without ANSI colors
    /*final content = _shouldUseANSI
        ? '$ansiColor$bgEmoji $iconEmoji [$timestamp] [$tag] $message$_reset'
        : '$bgEmoji $iconEmoji [$timestamp] [$tag] $message';*/
    final content =
        _shouldUseANSI
            ? '$ansiColor$iconEmoji [$timestamp] [$tag] $message$_reset'
            : '$iconEmoji [$timestamp] [$tag] $message';

    // Calculate border length based on visible content (excluding ANSI codes)
    final visibleContent = '$bgEmoji $iconEmoji [$timestamp] [$tag] $message';
    final contentLength = visibleContent.length;
    final border = _horizontal * (contentLength + 2); // +2 for padding spaces

    // Print with colors on Android, without on iOS - but same box design
    if (_shouldUseANSI) {
      // Android: Colored box design
      debugPrint('$ansiColor$_topLeft$border$_topRight$_reset');
      debugPrint(
        '$ansiColor$_vertical$_reset $content $ansiColor$_vertical$_reset',
      );
      debugPrint('$ansiColor$_bottomLeft$border$_bottomRight$_reset');
    } else {
      // iOS: Same box design but no colors
      debugPrint('$_topLeft$border$_topRight');
      debugPrint('$_vertical $content $_vertical');
      debugPrint('$_bottomLeft$border$_bottomRight');
    }

    // Empty line for separation
    debugPrint('');
  }

  // Utility method to test all log types
  static void testAllLogTypes() {
    info('This is an info message');
    success('This is a success message');
    warning('This is a warning message');
    error('This is an error message');
    debug('This is a debug message');
    network('This is a network message');
    database('This is a database message');
    performance('This is a performance message');
    security('This is a security message');
  }

  // Method to print a custom colored log
  static void custom(
    String message,
    String tag,
    String emoji,
    String ansiColor,
  ) {
    _printLog(emoji, emoji, message, tag, ansiColor);
  }
}
