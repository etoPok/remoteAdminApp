import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_admin_app/data/services/preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';

import '../data/models/request.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({super.key, required this.request});

  final Request request;

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  bool save = false;
  late Request newRequest;

  @override
  void initState() {
    super.initState();
    newRequest = Request(
      id: widget.request.id,
      userName: widget.request.userName,
      message: widget.request.message,
      action: widget.request.action,
      date: widget.request.date,
      state: widget.request.state,
      responseMessage: widget.request.responseMessage,
      responseDate: widget.request.responseDate
    );
  }

  String formatDateWithTime(DateTime? date) {
    if (date == null) return "Fecha no disponible";
    final formatter = DateFormat("d 'de' MMMM 'de' y 'a las' HH:mm", 'es_ES');
    return formatter.format(date);
  }

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
    // return Scaffold(
    //   appBar: AppBar(),
    // );
    final prefs = Provider.of<PreferencesProvider>(context);

    void deleteRequest() {
      Navigator.pop(context, {"delete": true, "newRequest": null});
    }

    Widget getOptions() {
      if (newRequest.state != StateRequest.pending) {
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
            onPressed: () {
              setState(() {
                newRequest = newRequest.copyWith(
                  state: StateRequest.approved,
                  responseDate: tz.TZDateTime.now(tz.local)
                );
                save = true;
              });
            },
            style: TextButton.styleFrom(
              backgroundColor: Color(0xFF2b2b2b)
            ),
            // child: const Text("Aprobar")
            label: const Text("Aprobar")
          ),

          SizedBox(width: 16),
          TextButton.icon(
            onPressed: () {
              setState(() {
                newRequest = newRequest.copyWith(
                  state: StateRequest.denied,
                  responseDate: tz.TZDateTime.now(tz.local)
                );
                save = true;
              });
            },
            style: TextButton.styleFrom(
              backgroundColor: Color(0xFF2b2b2b)
            ),
            label: const Text("Negar"),
          )
        ]
      );
    }

    Widget getResponseOption() {
      if (newRequest.state != StateRequest.pending) {
        return ListTile(
          title: const Text("Respuesta"),
          subtitle: Text(newRequest.responseMessage ?? "Sin respuesta")
        );
      }

      return ListTile(
        title: const Text("Respuesta"),
        subtitle: TextField(
          onSubmitted: (value) {
            newRequest = newRequest.copyWith(responseMessage: value);
          }
        )
      );
    }

    Widget getResponseDate() {
      if (newRequest.state == StateRequest.pending) {
        return SizedBox.shrink();
      }

      return ListTile(
        title: const Text("Fecha de respuesta"),
        subtitle: Text(formatDateWithTime(newRequest.responseDate))
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Solicitud"),
        leading: IconButton(
          onPressed: () {
            if (!save)
              {Navigator.pop(context, {"delete": false, "newRequest": null});}
            else
              {Navigator.pop(context, {"delete": false, "newRequest": newRequest});}
          },
          icon: Icon(Icons.arrow_back)
        )
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
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
                            title: Text(newRequest.userName),
                            trailing: Text(_getDayName(newRequest.date.weekday)),
                            subtitle: Text(
                              newRequest.sState ?? "Sin estado",
                              style: TextStyle(fontSize: 13)
                            )
                          ),

                          SizedBox(height: 16),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: const Text("Mensaje", style: TextStyle(fontSize: 16))
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                            child: Text(newRequest.message, style: TextStyle(fontSize: 14))
                          ),

                          SizedBox(height: 16),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: const Text("Acción", style: TextStyle(fontSize: 16))
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                            child: Text(newRequest.action)
                          )
                        ],
                      ),
                    )
                  ),

                  Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: getResponseOption()
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: getResponseDate()
                        )
                      ],
                    )
                  ),

                  SizedBox(height: 8),
                  getOptions()
                ]
              )
            ),

            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  height: 44,
                  width: 130,
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black87,
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                        child: IconButton(
                          icon: Icon(Icons.delete_outline),
                          onPressed: () {
                            if (prefs.confirmBeforeDelete) {
                              showDialog(
                                context: context,
                                builder: (BuildContext dialogContext) {
                                  return AlertDialog(
                                    title: Text("¿Eliminar solicitud?"),
                                      content: Text(
                                        "Eliminar una solicitud pendiente se negará inmediatamente. "
                                        "Obtendrá actualizaciones de solicitudes que haya procesado aunque se eliminen.",
                                      ),
                                      actions: [
                                        TextButton(
                                          child: Text("Cancelar"),
                                          onPressed: () {
                                            Navigator.of(dialogContext).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text("Eliminar"),
                                          onPressed: () {
                                            Navigator.of(dialogContext).pop();
                                            deleteRequest();
                                          },
                                        ),
                                      ]
                                  );
                              });
                            } else {
                              deleteRequest();
                            }
                          },
                        ),
                      )
                    ],
                  )
                )
              )
            )
          ],
        )
      )
    );
  }
}