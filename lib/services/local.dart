import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  static final LocalDatabase _instance = LocalDatabase._internal();
  factory LocalDatabase() => _instance;
  LocalDatabase._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'users.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, useremail TEXT, userpass TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertUser(String username, String useremail, String userpass) async {
    try {
      final db = await database;
      print('Insertion dans SQLite : $username, $useremail, $userpass');
      await db.insert(
        'users',
        {
          'username': username,
          'useremail': useremail,
          'userpass': userpass,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,

      );
      print('Utilisateur inséré dans SQLite : $username');
    } catch (e) {
      print('Erreur lors de l\'insertion dans SQLite : ${e.toString()}');
    }
  }

  Future<void> logAllUsers() async {
    final users = await fetchUsers();
    print('Utilisateurs dans SQLite : $users');
  }

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    final db = await database;
    return db.query('users');
  }
}