import 'package:flutter/material.dart';

import 'profile.dart';
import 'request.dart';
import '../data/models/request.dart';

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

  void _setRequests(StateRequest state) {
    setState(() {
      displayedRequests.clear();
      displayedRequests.addAll(requests.where((e) => e.state == state));
    });
  }

  void _setAll() {
    setState(() {
      displayedRequests.clear();
      displayedRequests.addAll(requests);
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
                _setAll();
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
          ],
        ),
      ),
    );
  }
}