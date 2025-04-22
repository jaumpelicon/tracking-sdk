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
        if (debugCreator != null && debugCreator is DebugCreator) {
          final element = debugCreator.element;
          final key = element.widget.key;

          if (key != null) {
            String keyStr;
            // Verificar o tipo específico de key para extrair o valor correto
            if (key is ValueKey) {
              keyStr = key.value.toString();
            } else {
              keyStr = key.toString();
            }
            Tracker.logClickEvent(keyStr, context);
            break;
          }
        }
      }
    }
  }
}
