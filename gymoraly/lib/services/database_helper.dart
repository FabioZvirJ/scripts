import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
// ADD THIS IMPORT: Point it to where your actual user_model.dart is located
import 'package:gymoraly/models/user_model.dart'; 

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'gymoraly.db');
    return await openDatabase(
      path,
      version: 2, 
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            name TEXT, 
            email TEXT, 
            password TEXT,
            age INTEGER,
            gender TEXT,
            height REAL,
            weight REAL
          )
          ''',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion < 2) {
          db.execute('DROP TABLE IF EXISTS users');
          db.execute(
            '''
            CREATE TABLE users(
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              name TEXT, 
              email TEXT, 
              password TEXT,
              age INTEGER,
              gender TEXT,
              height REAL,
              weight REAL
            )
            ''',
          );
        }
      },
    );
  }

  // Inserir Usuário (Cadastro Final)
  Future<int> registerUser(User user) async {
    final db = await database;
    return await db.insert('users', user.toMap());
  }

  // Buscar Usuário por E-mail e Senha (Login)
  Future<User?> loginUser(String email, String password) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }
}
