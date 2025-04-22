import 'package:flutter/material.dart';
import '../interceptors/click_interceptor.dart';

class TrackedPage extends StatelessWidget {
  final Widget child;

  const TrackedPage({required this.child});

  @override
  Widget build(BuildContext context) {
    return ClickInterceptor(child: child);
  }
}