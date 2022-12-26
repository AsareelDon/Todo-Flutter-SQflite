import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ConnDatabase {
  Database? _db;
  Future<Database> get database async {
    var databasePath = await getDatabasesPath();
    const databaseName = 'TodoApp.db';
    var path = join(databasePath, databaseName);
    _db = await openDatabase(path, version: 1, onCreate: createDatabase);
    return _db!;
  }

  void createDatabase(Database cursor, int version) async {
    await cursor.execute('''
      CREATE TABLE tblTodo(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        timestamp TEXT,
        status INTEGER)''');
  }
}