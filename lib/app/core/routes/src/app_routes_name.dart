part of "../library/routes_library.dart";

abstract class Routes {
  static const splash = _Paths.splash;
  static const animationPage = _Paths.animationPage;
  static const sqflitePage = _Paths.sqflitePage;
}

abstract class _Paths {
  static const splash = '/';
  static const animationPage = "/animation-page";
  static const sqflitePage = "/sqflite-page";
}
