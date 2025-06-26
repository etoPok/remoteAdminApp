import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/request.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() { return _instance; }

  DatabaseHelper._internal();

  Future<void> initializeDatabase() async {
    await database;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'remoteadmin_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate
    );
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE [request] (
        [id] INTEGER PRIMARY KEY AUTOINCREMENT,
        [userName] TEXT NOT NULL,
        [message] TEXT NOT NULL,
        [action] TEXT NOT NULL,
        [date] TEXT NOT NULL,
        [state] TEXT NOT NULL,
        [responseMessage] TEXT NOT NULL,
        [responseDate] TEXT NOT NULL
      )
    ''');
  }

  Future<Request> insertRequest(Request request) async {
    final db = await database;
    int newId = await db.insert(
      'request',
      request.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );

    return Request(
      id: newId,
      userName: request.userName,
      message: request.message,
      action: request.action,
      date: request.date,
      state: request.state,
      responseMessage: request.responseMessage,
      responseDate: request.responseDate
    );
  }

  Future<List<Map<String, Object?>>> getRequests() async {
    final db = await database;
    return await db.query("request");
  }

  Future<bool> deleteRequest(int? id) async {
    final db = await database;
    int rowsAffected = 0;

    if (id == null) {
      rowsAffected = await db.delete("request");
      return rowsAffected > 0;
    }

    rowsAffected = await db.delete(
      "request",
      where: 'id = ?',
      whereArgs: [id]
    );
    return rowsAffected > 0;
  }

  Future<Map<String, dynamic>> getRequest(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query(
      "request",
      where: 'id = ?',
      whereArgs: [id]
    );

    return results.first;
  }

  Future<void> updateRequest(int id, Request newRequest) async {
    final originalMap = await getRequest(id);
    final newMap = newRequest.toMap();

    final Map<String, dynamic> updates = {};
    for (var key in originalMap.keys) {
      if (newMap.containsKey(key) && originalMap[key] != newMap[key]) {
        updates[key] = newMap[key];
      }
    }

    final db = await database;
    if (updates.isEmpty) return;

    await db.update(
      'request',
      updates,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}