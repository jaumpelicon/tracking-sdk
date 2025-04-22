import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../tracker.dart';

class ClickInterceptor extends StatelessWidget {
  final Widget child;

  const ClickInterceptor({required this.child});

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (event) => _handleClick(context, event),
      child: child,
    );
  }

  void _handleClick(BuildContext context, PointerDownEvent event) {
    final hitTestResult = HitTestResult();
    WidgetsBinding.instance.hitTestInView(hitTestResult, event.position, event.viewId);

    for (final entry in hitTestResult.path) {
      final target = entry.target;
      if (target is RenderObject) {
        final debugCreator = target.debugCreator;
        if (debugCreator is DebugCreator) {
          final element = debugCreator.element;

          // Tenta pegar a key do próprio elemento
          final key = _findClosestValueKey(element);
          if (key != null) {
            final keyStr = key.value.toString();
            debugPrint('🔥 Clicked ValueKey: $keyStr');
            Tracker.logClickEvent(keyStr, context);
            return;
          }
        }
      }
    }
  }

  ValueKey? _findClosestValueKey(Element element) {
    Widget currentWidget = element.widget;

    if (currentWidget.key is ValueKey) {
      return currentWidget.key as ValueKey;
    }

    ValueKey? foundKey;
    element.visitAncestorElements((ancestor) {
      final key = ancestor.widget.key;
      if (key is ValueKey) {
        foundKey = key;
        return false; // parar no primeiro que encontrar
      }
      return true; // continua procurando
    });

    return foundKey;
  }
}
