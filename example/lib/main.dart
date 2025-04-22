import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tracking_sdk/tracker.dart';
import 'package:tracking_sdk/widgets/tracked_page.dart';
import 'package:tracking_sdk/interceptors/route_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final analytics = FirebaseAnalytics.instance;
  Tracker.configure(
    debugMode: true,
    logEventFunction: analytics.logEvent,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tracking SDK Demo',
      navigatorObservers: [TrackerRouteObserver()],
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TrackedPage(
      child: Scaffold(
        appBar: AppBar(title: Text('Home')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              key: Key('botao_login'),
              onPressed: () {},
              child: Text('Login'),
            ),
            ElevatedButton(
              key: Key('botao_cadastro'),
              onPressed: () {},
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
