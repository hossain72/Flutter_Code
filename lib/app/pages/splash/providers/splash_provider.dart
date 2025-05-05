import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../../../core/routes/library/routes_library.dart';

class SplashProvider extends ChangeNotifier {
  SplashProvider() {
    Future.microtask(() => init());
  }

  Future<void> init() async {
    // Add any delay or checks if needed (e.g., auth check)
    await Future.delayed(const Duration(milliseconds: 300));
    Pages.goToOffAllNamedRouts(
      navigatorKey.currentContext!,
      Routes.animationPage,
    );
  }
}
