import 'package:flutter/material.dart';
import '../data/services/preferences.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(),
    // );
    final prefs = Provider.of<PreferencesProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Preferencias")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text("Notificaciones"),
            subtitle: const Text("Recibir notificaciones sobre nuevas solicitudes."),
            value: prefs.notificationsEnabled,
            onChanged: prefs.setNotificationsEnabled,
          ),
          SwitchListTile(
            title: const Text("Confirmar antes de eliminar"),
            subtitle: const Text("Mostrar advertencia antes de borrar una solicitud."),
            value: prefs.confirmBeforeDelete,
            onChanged: prefs.setConfirmBeforeDelete,
          ),
          SwitchListTile(
            title: const Text("Modo oscuro"),
            subtitle: const Text("Ajustar el tema de la aplicación."),
            value: prefs.darkMode,
            onChanged: prefs.setDarkMode,
          ),
          ListTile(
            title: const Text("Tiempo para responder"),
            subtitle: Text("${prefs.autoResponseDelay.inMinutes} minutos"),
            trailing: const Icon(Icons.timer),
            onTap: () async {
              final result = await showDialog<Duration>(
                context: context,
                builder: (_) => SimpleDialog(
                  title: const Text("Tiempo de respuesta"),
                  children: [
                    SimpleDialogOption(
                      child: const Text("5 minutos"),
                      onPressed: () => Navigator.pop(context, Duration(minutes: 5)),
                    ),
                    SimpleDialogOption(
                      child: const Text("15 minutos"),
                      onPressed: () => Navigator.pop(context, Duration(minutes: 15)),
                    ),
                    SimpleDialogOption(
                      child: const Text("30 minutos"),
                      onPressed: () => Navigator.pop(context, Duration(minutes: 30)),
                    ),
                  ],
                ),
              );

              if (result != null) prefs.setAutoResponseDelay(result);
            },
          ),
        ],
      ),
    );
  }
}