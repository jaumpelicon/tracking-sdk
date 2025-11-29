import 'package:flutter/material.dart';

class Tracker {
  static bool debug = false;
  static String currentRoute = 'unknown';
  static late Future<void> Function({
    required String name,
    Map<String, Object>? parameters,
  }) logScreenEvent;
  static late Future<void> Function({
    required String name,
    Map<String, Object>? parameters,
  }) logButtonEvent;

  static Future<void> configure({
    bool debugMode = false,
    required Future<void> Function({
      required String name,
      Map<String, Object>? parameters,
    }) logScreenEventFunction,
    required Future<void> Function({
      required String name,
      Map<String, Object>? parameters,
    }) logButtonClickEvent,
  }) async {
    try {
      debug = debugMode;
      logScreenEvent = logScreenEventFunction;
      logButtonEvent = logButtonClickEvent;
      debugPrint('Success initialize sdk');
    } catch (e) {
      debugPrint('Erro ao logar evento de inicialização: $e');
    }
  }

  static void setCurrentRoute(String routeName) {
    if (debug) debugPrint('📍 Navegou para: $routeName');
    logScreenEvent(
      name: 'navigate for: ${routeName}',
      parameters: {
        'path': routeName,
      },
    );
    currentRoute = routeName;
  }

  static Future<void> logClickEvent(String key, BuildContext context) async {
    final route = ModalRoute.of(context)?.settings.name ?? currentRoute;

    if (debug) {
      debugPrint('🖱️ Click detectado em: $key');
      debugPrint('📍 Tela: $route');
    }

    await logButtonEvent(
      name: 'click on: $key',
      parameters: {
        'key': key,
        'screen': route,
      },
    );
  }
}
