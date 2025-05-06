  part of routes;

  class Pages {
    static final routeManager = RouteManager();

    static String? _getCurrentRoute(BuildContext context) {
      if (!context.mounted) return null;

      try {
        String? currentRoute;
        Navigator.popUntil(context, (route) {
          currentRoute = route.settings.name;
          return true;
        });
        return currentRoute;
      } catch (e) {
        debugPrint('Error getting current route: $e');
        return null;
      }
    }

    // static Future<dynamic>? goToRouts(BuildContext context, String route,
    //     {dynamic arguments}) async {
    //   //  var value =
    //   await InternetConnectionChecker.isInternetConnected().then((value) async {
    //     if (value!) {
    //       return await Navigator.pushNamed(context, route, arguments: arguments);
    //     } else {
    //       AppDialog.showNoInternetDialog(context, okBtnFunction: (okBtnFunction) {
    //         Navigator.pop(context);
    //         goToRouts(context, route, arguments: arguments);
    //       });
    //     }
    //   });
    //   // return value;
    // }

    // static Future<dynamic>? goToOffAllNamedRouts(
    //     BuildContext context, String route,
    //     {dynamic arguments}) async {
    //   await InternetConnectionChecker.isInternetConnected().then((value) async {
    //     if (value!) {
    //       return await Navigator.pushNamedAndRemoveUntil(
    //           context,
    //           route,
    //           arguments: arguments,
    //           (Route<dynamic> route) => false);
    //     } else {
    //       AppDialog.showNoInternetDialog(context, okBtnFunction: (okBtnFunction) {
    //         Navigator.pop(context);
    //         goToOffAllNamedRouts(context, route, arguments: arguments);
    //       });
    //     }
    //   });
    // }

    /*  static Future<dynamic>? goToRouts(BuildContext context, String route, {dynamic arguments}) async {
      return await Navigator.pushNamed(context, route, arguments: arguments);
    }

    static Future<dynamic>? goToOffAllNamedRouts(BuildContext context, String route, {dynamic arguments}) async {
      return await Navigator.pushNamedAndRemoveUntil(
        context,
        route,
        arguments: arguments,
        (Route<dynamic> route) => false,
      );
    }

    static Future<dynamic>? goToNamedAndRemoveUntil(
      BuildContext context,
      String currentRoute,
      String goesToRoute, {
      dynamic arguments,
    }) async {
      return await Navigator.pushNamed(context, currentRoute, arguments: arguments).then((_) {
        Navigator.pushNamedAndRemoveUntil(context, goesToRoute, (route) => route.settings.name == goesToRoute);
      });
    }

    static Future<dynamic>? goToAndKeepRoute(
      BuildContext context,
      String goesToRoute,
      String backRoute, {
      dynamic arguments,
    }) async {
      return await Navigator.pushNamedAndRemoveUntil(
        context,
        goesToRoute,
        (Route<dynamic> route) => route.settings.name == backRoute,
        arguments: arguments,
      );
    }*/

    static Future<dynamic>? goToRouts(BuildContext context, String route, {dynamic arguments}) async {
      if (!context.mounted) return null;

      routeManager.addRoute(route);
      return await Navigator.pushNamed(context, route, arguments: arguments).then((value) {
        // Safely update the route manager after navigation
        if (context.mounted) {
          String? newRoute = _getCurrentRoute(context);
          if (newRoute != null) {
            routeManager.setCurrentRoute(newRoute);
          }
        }
        return value;
      });
    }

    // Updated goBack method with proper context checking
    static dynamic goBack<T extends Object?>(BuildContext context, [T? result]) {
      if (!context.mounted) return null;

      if (Navigator.canPop(context)) {
        // Store the current route name before popping
        String? currentRoute = _getCurrentRoute(context);

        // Pop the route with the provided result
        Navigator.of(context).pop(result);

        // Update route manager by removing the current route
        if (currentRoute != null) {
          routeManager.removeRoute(currentRoute);
        }

        // Only update the current route if context is still valid
        if (context.mounted) {
          String? newCurrentRoute = _getCurrentRoute(context);
          if (newCurrentRoute != null) {
            routeManager.setCurrentRoute(newCurrentRoute);
          }
        }
      } else {
        print('Cannot pop - no routes to pop');
      }
    }

    static Future<dynamic>? goToOffAllNamedRouts(BuildContext context, String route, {dynamic arguments}) async {
      if (!context.mounted) return null;

      routeManager.clearRoutes();
      routeManager.addRoute(route);

      return await Navigator.pushNamedAndRemoveUntil(
        context,
        route,
        arguments: arguments,
        (Route<dynamic> route) => false,
      );
    }

    static Future<dynamic>? goToNamedAndRemoveUntil(
      BuildContext context,
      String currentRoute,
      String goesToRoute, {
      dynamic arguments,
    }) async {
      if (!context.mounted) return null;

      routeManager.addRoute(currentRoute);
      return await Navigator.pushNamed(context, currentRoute, arguments: arguments).then((_) {
        if (context.mounted) {
          routeManager.addRoute(goesToRoute);
          return Navigator.pushNamedAndRemoveUntil(
            context,
            goesToRoute,
            (route) => route.settings.name == goesToRoute,
            arguments: arguments,
          );
        }
        return null;
      });
    }

    static Future<dynamic>? goToAndKeepRoute(
      BuildContext context,
      String goesToRoute,
      String backRoute, {
      dynamic arguments,
    }) async {
      if (!context.mounted) return null;

      routeManager.addRoute(goesToRoute);
      return await Navigator.pushNamedAndRemoveUntil(context, goesToRoute, (Route<dynamic> route) {
        bool shouldKeep = route.settings.name == backRoute;
        return shouldKeep;
      }, arguments: arguments);
    }

    static Future<void> popUntil(BuildContext context, String targetRoute) async {
      if (!context.mounted) return;

      // Remove current and target routes from route manager
      String? currentRoute = _getCurrentRoute(context);
      if (currentRoute != null) {
        routeManager.removeRoute(currentRoute);
      }

      // Use Navigator.popUntil to go back to the specified route
      Navigator.popUntil(context, (route) {
        bool shouldPop = route.settings.name == targetRoute;

        // Update route manager if the target route is found
        if (shouldPop) {
          routeManager.setCurrentRoute(targetRoute);
        }

        return shouldPop;
      });
    }
  }
