import 'package:flutter/material.dart';
import '../tracker.dart';

class TrackerRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  @override
  void didPush(Route route, Route? previousRoute) {
    _setCurrentRoute(route);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _setCurrentRoute(previousRoute);
  }

  void _setCurrentRoute(Route? route) {
    if (route is PageRoute) {
      final name = route.settings.name ?? 'undefined';
      Tracker.setCurrentRoute(name);
    }
  }
}