import 'package:flutter/material.dart';

import 'app/core/utils/svgList.dart';
import 'my_app.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  preloadSVGs(svgList);
  runApp(const MyApp());
}
