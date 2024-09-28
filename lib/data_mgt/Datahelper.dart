import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'DataModel.dart';


class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();
  static Database? _database;

  // Singleton pattern to ensure only one instance of DatabaseHelper
  DatabaseHelper._();

  factory DatabaseHelper() {
    return _instance;
  }

  // Table and column names for the User table
  static final String userTable = 'users';
  static final String columnId = 'id';
  static final String columnUsername = 'username';
  static final String columnEmail = 'email';
  static final String columnPassword = 'password';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'app_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {

    // Create User table
    await db.execute('''
      CREATE TABLE $userTable (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnUsername TEXT NOT NULL,
        $columnEmail TEXT NOT NULL,
        $columnPassword TEXT NOT NULL
      )
    ''');
  }

  // Insert a new user into the database
  Future<int> insertUser(User user) async {
    Database db = await database;
    return await db.insert(userTable, user.toMap());
  }

  // Fetch a user by email
  Future<User?> getUserByEmail(String email) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      userTable,
      where: '$columnEmail = ?', // Query by email
      whereArgs: [email], // Email argument
    );

    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    } else {
      return null; // No user found
    }
  }



}
