part of routes;

class RouteManager {
  // Singleton instance
  static final RouteManager _instance = RouteManager._internal();

  factory RouteManager() => _instance;

  RouteManager._internal();

  // List to track route history
  final List<String> _routeList = [];

  // Current visible route
  String _currentRoute = '';

  // Getter for current route
  String get currentRoute => _currentRoute;

  // Getter for route list
  List<String> get routeList => List.unmodifiable(_routeList);

  // Add route when navigating to a new page
  void addRoute(String routeName) {
    // Only add the route if it doesn't already exist in the list
    if (!_routeList.contains(routeName)) {
      _routeList.add(routeName);
    }
    // Always update the current route
    _currentRoute = routeName;
    _logRouteStatus();
  }

  // Remove route when navigating back
  void removeRoute(String routeName) {
    if (_routeList.contains(routeName)) {
      int index = _routeList.indexOf(routeName);
      _routeList.removeAt(index);

      // Set current route to the top of the stack after removal
      if (_routeList.isNotEmpty) {
        _currentRoute = _routeList.last;
      } else {
        _currentRoute = '';
      }
    }
    _logRouteStatus();
  }

  // Update current route without adding to list (for handling back navigation)
  void setCurrentRoute(String routeName) {
    _currentRoute = routeName;
    _logRouteStatus();
  }

  // Clear all routes (useful for logout or reset)
  void clearRoutes() {
    _routeList.clear();
    _currentRoute = '';
    _logRouteStatus();
  }

  // Helper to log the current state
  void _logRouteStatus() {
    //debugPrint('Current Route: $_currentRoute');
    //debugPrint('Route History: $_routeList');
  }
}
