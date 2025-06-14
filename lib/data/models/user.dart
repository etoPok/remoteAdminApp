import 'package:flutter/widgets.dart';

class User {
  String _name;
  AssetImage _img;
  final String _role;
  String _authorizationPassword;
  String _administratorPassword;

  User({
    required String name,
    required String authorizationPassword,
    required String administratorPassword,
    required AssetImage img
  }) : _name = name,
    _authorizationPassword = authorizationPassword,
    _administratorPassword = administratorPassword,
    _role = "Admin",
    _img = img;

  String get name => _name;
  String get role => _role;
  AssetImage get img => _img;
}