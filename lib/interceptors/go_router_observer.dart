import 'package:flutter/material.dart';
import 'package:tracking_sdk/tracker.dart';

class GoRouterTrackerObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log(previousRoute);
  }

  void _log(Route<dynamic>? route) {
    if (route is PageRoute) {
      final name = route.settings.name ?? route.runtimeType.toString();
      Tracker.setCurrentRoute(name);
    }
  }
}
