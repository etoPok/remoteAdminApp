import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/date_symbol_data_local.dart';

import 'pages/splash.dart';
import 'theme/theme.dart';
import 'theme/util.dart';
import 'data/services/local_notifications_plugin.dart';
import 'data/services/database_helper.dart';
import 'data/services/preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DatabaseHelper dbHelper = DatabaseHelper();
  await dbHelper.initializeDatabase();

  await initializeDateFormatting('es_ES', null);

  final timezone = await FlutterTimezone.getLocalTimezone();
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation(timezone));

  AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('remote_admin');

  InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => PreferencesProvider(),
      child: const MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, prefs, _) {
        TextTheme textTheme = createTextTheme(context, "Abel", "Abel");
        MaterialTheme theme = MaterialTheme(textTheme);

        return MaterialApp(
          theme: theme.light(),
          darkTheme: theme.dark(),
          themeMode: prefs.darkMode ? ThemeMode.dark : ThemeMode.light,
          home: const SplashPage(),
        );
      },
    );
  }
}