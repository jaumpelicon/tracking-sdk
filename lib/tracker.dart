import 'package:flutter/material.dart';

class Tracker {
  static bool debug = false;
  static String currentRoute = 'unknown';
  static late void Function({
    required String name,
    Map<String, Object>? parameters,
  }) logEvent;

  static void configure({
    bool debugMode = false,
    required void Function({
      required String name,
      Map<String, Object>? parameters,
    }) logEventFunction,
  }) {
    debug = debugMode;
    logEvent = logEventFunction;
  }

  static void setCurrentRoute(String routeName) {
    if (debug) debugPrint('📍 Navegou para: $routeName');
    logEvent(
      name: 'screen_view',
      parameters: {
        'path': routeName,
      },
    );
    currentRoute = routeName;
  }

  static void logClickEvent(String key, BuildContext context) {
    final route = ModalRoute.of(context)?.settings.name ?? currentRoute;

    if (debug) {
      debugPrint('🖱️ Click detectado em: $key');
      debugPrint('📍 Tela: $route');
    }

    logEvent(
      name: 'widget_click',
      parameters: {
        'key': key,
        'screen': route,
      },
    );
  }
}
