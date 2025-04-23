# tracking_sdk

A lightweight SDK to automatically track user interactions and navigation in Flutter apps using Firebase Analytics.

## 🚀 Features

- 🔍 Tracks button clicks based on `Key` without modifying widgets.
- 📍 Observes navigation using a custom `RouteObserver`.
- 🔥 Integrates easily with Firebase Analytics.

## 📦 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  tracking_sdk: ^0.1.0
```

🛠️ Usage
```dart
import 'package:flutter/material.dart';
import 'package:tracking_sdk/tracking_sdk.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await Tracker.configure(
    debugMode: true,
    logEventFunction: FirebaseAnalytics.instance.logEvent,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ClickInterceptor(
      child: MaterialApp(
        navigatorObservers: [RouteTrackerObserver()], 
        home: HomePage(),
      ),
    );
  }
}

class MyAppGoRouter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ClickInterceptor(
      child: MaterialApp.router(
        routerConfig: GoRouter(
          initialLocation: 'home',
          observers: [RouteTrackerObserver()],
          routes: <RouteBase>[
              GoRoute(
                path: 'home',
                name: 'home',
                builder: (_, __) => const HomePage(),
              ),
           ],
         ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TrackingListener(
      analytics: analytics,
      child: Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: Center(
          child: ElevatedButton(
            key: const Key('purchase_button'),
            onPressed: () {
              // Your business logic
            },
            child: const Text('Purchase'),
          ),
        ),
      ),
    );
  }
}
```

📚 Documentation
See the [GitHub repository](https://github.com/jaumpelicon/tracking-sdk/) for source code and future updates.

🐞 Issues
Found a bug or have a feature request? Please open an issue at our Issue Tracker.

📄 License
This project is licensed under the MIT License - see the LICENSE file for details.