import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'Shop.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  DatabaseHelper._init();

  static final String TABLE_NAME = "shop";
  static final String COLUMN_ID = "id";
  static final String COLUMN_NAME = "name";
  static final String COLUMN_EMAIL = "email";
  static final String COLUMN_PASSWORD = "password";

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("customer.db");
    return _database!;
  }

  Future<Database> _initDB(String filename) async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, filename);
    return await openDatabase(path, version: 1, onCreate: _onCreateDB);
  }

  Future<void> _onCreateDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $TABLE_NAME (
        $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,
        $COLUMN_NAME TEXT NOT NULL,
        $COLUMN_EMAIL TEXT NOT NULL,
        $COLUMN_PASSWORD TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertShop(Shop shop) async {
    final db = await database;
    return await db.insert(TABLE_NAME, shop.toMap());
  }

  Future<List<Shop>> getShop() async {
    final db = await database;
    final result = await db.query(TABLE_NAME);
    return result.map((e) => Shop.fromMap(e)).toList();
  }
  Future<Map<String, dynamic>?> getUserByEmailAndPassword(
      String email, String password) async {
    final db = await database;
    final res = await db.query(
      TABLE_NAME,
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (res.isNotEmpty) {
      return res.first; // the first row found
    }
    return null; // no user found
  }

}
