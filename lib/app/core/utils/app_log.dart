import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'flavor_config.dart';

class AppLog {
  static const _red = '\x1B[31m';
  static const _green = '\x1B[32m';
  static const _reset = '\x1B[0m';

  static void log(String msg) {
    if (kDebugMode || FlavorConfig.isDEV()) {
      debugPrint("✅ $_green$msg$_reset");
    }
  }

  static void logError(String msg) {
    if (kDebugMode || FlavorConfig.isDEV()) {
      debugPrint("❌ $_red$msg$_reset");
    }
  }
}
