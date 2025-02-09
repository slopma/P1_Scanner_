import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('usuarios.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE usuarios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL
      )
    ''');
  }

  Future<Map<String, dynamic>?> obtenerUsuarioPorEmail(String email) async {
    final db = await instance.database;
    final result = await db.query(
      'usuarios',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }


  Future<int> agregarUsuario(String nombre, String email, String password) async {
    final db = await instance.database;
    final id = await db.insert('usuarios', {
      'nombre': nombre,
      'email': email,
      'password': password,
    });

    await _guardarSesion(email);
    return id;
  }

  Future<Map<String, dynamic>?> autenticarUsuario(String email, String password) async {
    final db = await instance.database;
    final result = await db.query(
      'usuarios',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      await _guardarSesion(email);
      return result.first;
    }
    return null;
  }

  Future<void> _guardarSesion(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final usuarioRegistrado = await obtenerSesion();

    if (usuarioRegistrado == null) {
      await prefs.setString('usuario_actual', email);
    }
  }

  Future<String?> obtenerSesion() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('usuario_actual');
  }

  Future<void> cerrarSesion() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('usuario_actual');
  }
}
