import 'package:todo_app/models/todo_db.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:sqflite/sqflite.dart';

class Controller {
  ConnDatabase db = ConnDatabase();

  Future<List<Map<String, dynamic>>> fetchData() async {
    final conn = await db.database;
    var result = await conn.rawQuery('SELECT * FROM tblTodo ORDER BY id DESC');
    return result;
  }

  Future<void> insertData(Todo todo) async {
    var conn = await db.database;
    await conn.insert('tblTodo', todo.toMap(), conflictAlgorithm: ConflictAlgorithm.replace,);
  }

  Future<void> deleteRow(int id) async {
    var conn = await db.database;
    await conn.delete('tblTodo', where: 'id == ?', whereArgs: [id],);
  }
  Future<void> updateRow(Todo todo) async {
    final conn = await db.database;
    await conn.update('tblTodo', todo.toMap(), where: 'id == ?', whereArgs: [todo.id],);
  }

}