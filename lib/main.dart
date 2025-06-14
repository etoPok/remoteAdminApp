import 'package:flutter/material.dart';

import 'pages/splash.dart';
import 'theme/theme.dart';
import 'theme/util.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme = createTextTheme(context, "Abel", "Abel");
    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      title: 'RemoteAdmin',
      theme: theme.dark(),
      home: const SplashPage(),
    );
  }
}