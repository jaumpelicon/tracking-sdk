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
    WidgetsBinding.instance.hitTest(hitTestResult, event.position);

    for (final entry in hitTestResult.path) {
      final target = entry.target;
      if (target is RenderObject) {
        final debugCreator = target.debugCreator;
        if (debugCreator != null && debugCreator is DebugCreator) {
          final element = debugCreator.element;
          final key = element.widget.key;

          if (key != null) {
            final keyStr = key.toString();
            Tracker.logClickEvent(keyStr, context);
            break;
          }
        }
      }
    }
  }
}
