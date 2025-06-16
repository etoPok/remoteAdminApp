import 'package:flutter/material.dart';

import 'profile.dart';
import 'request.dart';
import '../entity/request.dart';
import 'about.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  // List<Request> displayedRequests = requests;    // jaja que bobo
  List<Request> displayedRequests = List<Request>.from(requests);
  String appBarTitle = "Todo";

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

      body: Padding(
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
                  );
                }
              )
            );
          },
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
              title: const Text('Configuración'),
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
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