import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  DatabaseHelper.internal();

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'polls.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE IF NOT EXISTS tokens (id INTEGER PRIMARY KEY, token TEXT)');
      },
    );
  }

  Future<void> saveToken(String token) async {
    Database db = await database;
    await db.insert('tokens', {'token': token});
  }

  Future<String?> getToken() async {
    Database db = await database;
    List<Map<String, dynamic>> tokens = await db.query('tokens');
    if (tokens.isNotEmpty) {
      return tokens.first['token'] as String?;
    }
    return null;
  }

  Future<void> clearTokens() async {
    Database db = await database;
    await db.delete('tokens');
  }
}
