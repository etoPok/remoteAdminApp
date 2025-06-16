import '../entity/user.dart';

import 'package:flutter/material.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const TextStyle h1TextStyle = TextStyle(
    fontSize: 18,
    color: Colors.white
  );

  static const TextStyle h2TextStyle = TextStyle(
    color: Colors.white70
  );

  static const Divider divider = Divider(
    color: Colors.black12,
    thickness: 1,
    height: 1,
    indent: 16,
    endIndent: 0,
  );

  User user = User(
    name: "SongJoo",
    authorizationPassword: "authorizationPassword",
    administratorPassword: "administratorPassword",
    img: AssetImage("assets/img/foto_perfil.jpg")
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Perfil")),

      body: ListView(
        padding: EdgeInsets.all(16),
        scrollDirection: Axis.vertical,

        children: <Widget>[
          // User
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: <Widget>[
                SizedBox(height: 16),
                CircleAvatar(
                  backgroundImage: user.img,
                  radius: 40,
                ),
                SizedBox(height: 8),

                Text(
                  user.name,
                  style: h1TextStyle,
                ),
                Text(
                  user.role,
                  style: h2TextStyle,
                ),
                SizedBox(height: 16),
              ]
            )
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: const Text("Opciones", style: TextStyle(color: Colors.white, fontSize: 22))
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    onTap: () => {},
                    title: const Text(
                      "Sistemas",
                      style: h1TextStyle,
                    ),
                  ),
                ),

                divider,
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    onTap: () => {},
                    title: const Text(
                      "Cambiar clave de autorización",
                      style: h1TextStyle,
                    ),
                  ),
                ),

                divider,
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    onTap: () => {},
                    title: const Text(
                      "Comprobar clave de administrador",
                      style: h1TextStyle,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}