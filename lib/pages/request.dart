import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_admin_app/data/services/preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';

import 'package:remote_admin_app/data/services/database_helper.dart';
import 'package:remote_admin_app/data/models/request.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({super.key, required this.request});

  final Request request;

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  late Request newRequest;
  DatabaseHelper dbHelper = DatabaseHelper();
  final TextEditingController controllerResponseMessage = TextEditingController();

  @override
  void initState() {
    super.initState();
    newRequest = widget.request.copyWith();
  }

  @override
  void dispose() {
    super.dispose();
    controllerResponseMessage.dispose();
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

  Future<void> _deleteRequest() async {
    await dbHelper.deleteRequest(newRequest.id);
    if (!mounted) return;
    Navigator.pop(context);
  }

  Widget _getApproveAndRejectOptions() {
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
          onPressed: () async {
            bool confirm = false;
            showDialog(
              context: context,
              builder: (BuildContext dialogContext) {
                return AlertDialog(
                  title: const Text("¿Aprobar solicitud?"),
                  content: const Text("Al aprobar la solicitud se preparará en el sistema remoto la tarea con privilegios y el usuario podrá ejecutarla"),
                  actions: [
                    TextButton(
                      onPressed: () { confirm = false; Navigator.of(dialogContext).pop(); },
                      child: const Text("Cancelar")
                    ),
                    TextButton(
                      onPressed: () { confirm = true; Navigator.of(dialogContext).pop(); },
                      child: const Text("Aprobar")
                    )
                  ],
                );
              }
            ).then((_) async {
              if (!confirm) return;

              newRequest = newRequest.copyWith(
                state: StateRequest.approved,
                responseDate: tz.TZDateTime.now(tz.local),
                responseMessage: controllerResponseMessage.text
              );

              await dbHelper.updateRequest(newRequest.id, newRequest);
              setState(() {});
            });

          },
          style: TextButton.styleFrom(
            backgroundColor: Color(0xFF2b2b2b)
          ),
          label: const Text("Aprobar")
        ),

        SizedBox(width: 16),
        TextButton.icon(
          onPressed: () async {
            bool confirm = false;
            showDialog(
              context: context,
              builder: (BuildContext dialogContext) {
                return AlertDialog(
                  title: const Text("Rechazar solicitud?"),
                  content: const Text("Al denegar la solicitud el usuario será notificado y la tarea no tendrá efecto en el sistema remoto"),
                  actions: [
                    TextButton(
                      onPressed: () { confirm = false; Navigator.of(dialogContext).pop(); },
                      child: const Text("Cancelar")
                    ),
                    TextButton(
                      onPressed: () { confirm = true; Navigator.of(dialogContext).pop(); },
                      child: const Text("Denegar")
                    )
                  ],
                );
              }
            ).then((_) async {
              if (!confirm) return;

              newRequest = newRequest.copyWith(
                state: StateRequest.denied,
                responseDate: tz.TZDateTime.now(tz.local),
                responseMessage: controllerResponseMessage.text
              );

              await dbHelper.updateRequest(newRequest.id, newRequest);
              setState(() {});
            });

          },
          style: TextButton.styleFrom(
            backgroundColor: Color(0xFF2b2b2b)
          ),
          label: const Text("Denegar"),
        )
      ]
    );
  }

  Widget _getAnswerOption() {
    if (newRequest.state != StateRequest.pending) {
      return ListTile(
        title: const Text("Respuesta"),
        subtitle: Text(newRequest.responseMessage ?? "Sin respuesta")
      );
    }

    return ListTile(
      title: const Text("Respuesta"),
      subtitle: TextField(
        controller: controllerResponseMessage,
      )
    );
  }

  Widget _getAnswerDate() {
    if (newRequest.state == StateRequest.pending) {
      return SizedBox.shrink();
    }

    return ListTile(
      title: const Text("Fecha de respuesta"),
      subtitle: Text(formatDateWithTime(newRequest.responseDate))
    );
  }

  @override
  Widget build(BuildContext context) {
    final prefs = Provider.of<PreferencesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Solicitud"),
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
                              newRequest.state.legibleName,
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
                          child: _getAnswerOption()
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: _getAnswerDate()
                        )
                      ],
                    )
                  ),

                  SizedBox(height: 8),
                  _getApproveAndRejectOptions()
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
                            if (!prefs.confirmBeforeDelete) { _deleteRequest(); return; }

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
                                      onPressed: () async {
                                        Navigator.of(dialogContext).pop();
                                        _deleteRequest();
                                      },
                                    ),
                                  ]
                                );
                            });
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