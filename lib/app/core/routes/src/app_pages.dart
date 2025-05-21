part of "../library/routes_library.dart";

class AppPages {
  // when the app is opened, this page will be the first to be shown
  static const initial = Routes.splash;

  static Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          settings: settings,
          fullscreenDialog: true,
          builder: (context) => const SplashPage(),
        );
      case Routes.animationPage:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder:
              (context, animation, secondaryAnimation) => const AnimationPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeOutQuad;
            var tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case Routes.sqflitePage:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder:
              (context, animation, secondaryAnimation) =>
                  const SqfliteExample(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeOutQuad;
            var tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      default:
        throw Exception('Routs not found');
    }
  }
}
