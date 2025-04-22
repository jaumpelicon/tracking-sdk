import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class Tracker {
  static bool debug = false;
  static String currentRoute = 'unknown';

  static void setCurrentRoute(String routeName) {
    if (debug) debugPrint('📍 Navegou para: \$routeName');
    currentRoute = routeName;
  }

  static void logClickEvent(String key, BuildContext context) {
    final route = ModalRoute.of(context)?.settings.name ?? currentRoute;

    if (debug) {
      debugPrint('🖱️ Click detectado em: \$key');
      debugPrint('📍 Tela: \$route');
    }

    FirebaseAnalytics.instance.logEvent(
      name: 'widget_click',
      parameters: {
        'key': key,
        'screen': route,
      },
    );
  }

  static void configure({bool debugMode = false}) {
    debug = debugMode;
  }
}