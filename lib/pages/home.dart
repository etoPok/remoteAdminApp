import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:remote_admin_app/pages/settings.dart';
import 'package:timezone/timezone.dart' as tz;

import 'profile.dart';
import 'request.dart';
import '../data/models/request.dart';
import 'about.dart';
import '../data/services/local_notifications_plugin.dart';
import '../data/services/database_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Request> displayedRequests = [];
  String appBarTitle = "Todo";
  int _selectedIndex = 0;

  DatabaseHelper dbHelper = DatabaseHelper();

  bool _notificationsEnabled = false;
  bool _canSheduleNotifications = false;

  @override
  void initState() {
    super.initState();
    _initializeNotificationsPermissions().then((_) async {
      await _loadDatabase();
      if (_canSheduleNotifications) {
        await _sheduleNotification();
      }
    });
  }

  Future<void> _initializeNotificationsPermissions() async {
    if (!Platform.isAndroid) return;

    // no deberia ser nulo si se esta en la plataforma esperada
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      flutterLocalNotificationsPlugin.
      resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    bool notificationsEnabled = false;

    notificationsEnabled = await androidImplementation?.
      areNotificationsEnabled() ?? false;   // comprobar permisos
    if (!notificationsEnabled) {
      notificationsEnabled = await androidImplementation?.
        requestNotificationsPermission() ?? false;    // solicitar permisos
    }

    setState(() { _notificationsEnabled = notificationsEnabled; });
    if (!_notificationsEnabled) return;   // no continuar si no se puede mostrar notificaciones

    bool canSheduleNotifications = await androidImplementation?.
      requestExactAlarmsPermission() ?? false;    // solicitar permisos para programar notificaciones
    setState(() { _canSheduleNotifications = canSheduleNotifications; });
  }

  Future<void> _sheduleNotification() async {
    final newRequest = await dbHelper.insertRequest(
      Request(
        userName: "juanAdmin",
        message: "Necesito reiniciar el servicio de base de datos en el servidor de producción para aplicar un parche de seguridad crítico.",
        action: "Reinicio de servicio",
        date: tz.TZDateTime.now(tz.local),
        state: StateRequest.pending
      )
    );
    requests.add(newRequest);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id++,
      "Nueva solicitud de permisos de ${newRequest.userName}",
      newRequest.action,
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id', 'your channel name',
          channelDescription: 'your channel description')
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle
    );
  }

  Future<void> _loadDatabase() async {
    // se agregan las solicitudes en la database para crear, ver, editar
    // y eliminar desde la database.
    await dbHelper.deleteRequest(null);
    final copy = List<Request>.from(requests);
    final List<Request> requestsWithId = [];
    for (var r in copy) {
      Request rWithId = await dbHelper.insertRequest(r);
      requestsWithId.add(rWithId);
    }
    setState(() {
      requests.clear();
      requests.addAll(requestsWithId);
    });

    appBarTitle = "Todo";
    _setRequests(null);
  }

  Future<void> _updateRequest() async {
    requests.clear();
    final rs = await dbHelper.getRequests();
    for (var map in rs) {
      requests.add(Request.fromMap(map));
    }

    appBarTitle = "Todo";
    _setRequests(null);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const Divider divider = Divider(
    thickness: 1,
    height: 1,
    indent: 16,
    endIndent: 0,
  );

  /// Define por estado las solicitudes a mostrar. Si no especifica un estado
  /// mostrara todas las solicitudes.
  void _setRequests(StateRequest? state) {
    setState(() {
      displayedRequests.clear();
      if (state == null) {
        displayedRequests.addAll(requests);
      } else {
        displayedRequests.addAll(requests.where((e) => e.state == state));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),

      body: RefreshIndicator(
        onRefresh: _updateRequest,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(vertical: 8),
            itemCount: displayedRequests.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.zero,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/img/foto_perfil.jpg"),
                    radius: 30,
                  ),
                  title: Text(displayedRequests[index].userName),
                  subtitle: Text(
                    displayedRequests[index].action,
                    maxLines: 2,
                    style: TextStyle(color: Colors.white60, fontSize: 13)
                  ),
                  trailing: Text(displayedRequests[index].sState ?? "Sin estado"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RequestPage(request: displayedRequests[index]))
                    ).then((map) async {
                      if (map["delete"]) {
                        await dbHelper.deleteRequest(displayedRequests[index].id);
                        _updateRequest();
                      }

                      final Request? newRequest = map["newRequest"];
                      if (newRequest != null) {
                        await dbHelper.updateRequest(displayedRequests[index].id, newRequest);
                        _updateRequest();
                      }
                    });
                  }
                )
              );
            },
          ),
        ),
      ),

      drawer: Drawer(
        backgroundColor: Color(0xFF2f2f2f),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF2b2b2b)),
              child: Text('RemoteAdmin', style: TextStyle(color: Colors.white)),
            ),

            ListTile(
              leading: Icon(Icons.list_alt, color: Colors.white),
              title: const Text("Todo"),
              selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0);
                _setRequests(null);
                appBarTitle = "Todo";
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.hourglass_empty, color: Colors.white),
              title: const Text("Solicitudes pendientes"),
              selected: _selectedIndex == 4,
              onTap: () {
                _onItemTapped(4);
                _setRequests(StateRequest.pending);
                appBarTitle = "Solicitudes pendientes";
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.check_circle_outline, color: Colors.white),
              title: const Text("Solicitudes aprobadas"),
              selected: _selectedIndex == 2,
              onTap: () {
                _onItemTapped(2);
                _setRequests(StateRequest.approved);
                appBarTitle = "Solicitudes aprobadas";
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.cancel_outlined, color: Colors.white),
              title: const Text("Solicitudes negadas"),
              selected: _selectedIndex == 3,
              onTap: () {
                _onItemTapped(3);
                _setRequests(StateRequest.denied);
                appBarTitle = "Solicitudes negadas";
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.flag, color: Colors.white),
              title: const Text("Solicitudes ejecutadas"),
              selected: _selectedIndex == 5,
              onTap: () {
                _onItemTapped(5);
                _setRequests(StateRequest.executed);
                appBarTitle = "Solicitudes ejecutadas";
                Navigator.pop(context);
              },
            ),

            divider,
            ListTile(
              leading: Icon(Icons.account_circle_sharp, color: Colors.white),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.white),
              title: const Text('Preferencias'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline, color: Colors.white),
              title: const Text('Acerca'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}