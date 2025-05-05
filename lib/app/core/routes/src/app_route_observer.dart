part of routes;

class AppRouteObserver extends NavigatorObserver {
  final RouteManager routeManager = RouteManager();

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name != null) {
      routeManager.addRoute(route.settings.name!);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (route.settings.name != null) {
      routeManager.removeRoute(route.settings.name!);
    }
    if (previousRoute != null && previousRoute.settings.name != null) {
      routeManager.setCurrentRoute(previousRoute.settings.name!);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    /*if (oldRoute?.settings.name != null) {
      routeManager.removeRoute(oldRoute!.settings.name!);
    }
    if (newRoute?.settings.name != null) {
      routeManager.addRoute(newRoute!.settings.name!);
    }*/
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    /*if (route.settings.name != null) {
      routeManager.removeRoute(route.settings.name!);
    }
    if (previousRoute != null && previousRoute.settings.name != null) {
      routeManager.setCurrentRoute(previousRoute.settings.name!);
    }*/
  }
}
