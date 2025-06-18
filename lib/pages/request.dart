import '../data/models/request.dart';

import 'package:flutter/material.dart';


class RequestPage extends StatefulWidget {
  const RequestPage({super.key, required this.request});

  final Request request;

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  String _getDayName(int weekDay) {
    switch (weekDay) {
      case 1:
        return "lunes";
      case 2:
        return "martes";
      case 3:
        return "miércoles";
      case 4:
        return "jueves";
      case 5:
        return "viernes";
      case 6:
        return "sábado";
      case 7:
        return "domingo";
      default:
        return "";
    }
  }


  @override
  Widget build(BuildContext context) {
    Request request = widget.request;

    Widget getOptions() {
      if (request.state != StateRequest.pending) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Solicitud procesada", style: TextStyle(color: Colors.white))
          ],
        );
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextButton.icon(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: Color(0xFF2b2b2b)
            ),
            // child: const Text("Aprobar")
            label: const Text("Aprobar")
          ),

          SizedBox(width: 16),
          TextButton.icon(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: Color(0xFF2b2b2b)
            ),
            label: const Text("Negar"),
          )
        ]
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Request")),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            Card(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage("assets/img/foto_perfil.jpg"),
                        radius: 30
                      ),
                      title: Text(request.userName),
                      trailing: Text(_getDayName(request.date.weekday)),
                      subtitle: Text(
                        request.sState ?? "Sin estado",
                        style: TextStyle(color: Colors.white60, fontSize: 13)
                      )
                    ),

                    SizedBox(height: 16),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: const Text("Mensaje", style: TextStyle(color: Colors.white, fontSize: 16))
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                      child: Text(request.message, style: TextStyle(color: Colors.white60, fontSize: 14))
                    ),

                    SizedBox(height: 16),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: const Text("Acción", style: TextStyle(color: Colors.white, fontSize: 16))
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                      child: Text(request.action, style: TextStyle(color: Colors.white60, fontSize: 14))
                    )
                  ],
                ),
              )
            ),

            Card(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                      Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: const Text("Respuesta", style: TextStyle(color: Colors.white, fontSize: 16))
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                      child: Text("Ingrese su respuesta", style: TextStyle(color: Colors.white60, fontSize: 14))
                    )
                  ],
                ),
              )
            ),

            SizedBox(height: 8),
            getOptions()
          ],
        )
      )
    );
  }
}