import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/TodoServices/todoModel.dart';
import 'package:todoapp/TodoServices/todoProvider.dart';

class TodoDatabase {
  static final TodoDatabase instance = TodoDatabase._init();

  static Database? _database;

  TodoDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('todos.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    print(dbPath);
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableTodos ( 
  ${TodoFields.id} $idType, 
  ${TodoFields.todoTitle} $textType,
  ${TodoFields.todoCreatedDate} $textType,
  ${TodoFields.todoDeadline} $textType,
  ${TodoFields.status} $textType
  )
''');
    await db.execute('''
CREATE TABLE user ( 
  token $textType
  )
''');
  }

  Future<void> createUser(String user) async {
    final db = await instance.database;
    await db.rawInsert('INSERT INTO user (token) VALUES ("$user")');
  }

  Future<String> readUser() async {
    final db = await instance.database;
    final userlist = await db.query(
      'user',
    );
    String token = userlist.first['token'] as String;
    return token;
  }

  Future delete() async {
    final db = await instance.database;

    return await db.delete('user');
  }

  Future<TodoModel> createTodo(TodoModel todoModel, BuildContext con) async {
    final db = await instance.database;
    final json = {
      TodoFields.todoTitle: todoModel.todoTitle,
      TodoFields.todoCreatedDate: todoModel.todoCreatedDate,
      TodoFields.todoDeadline: todoModel.todoDeadline,
      TodoFields.status: todoModel.status
    };
    final columns =
        '${TodoFields.todoTitle}, ${TodoFields.todoCreatedDate}, ${TodoFields.todoDeadline}, ${TodoFields.status}';
    final values =
        '"${json[TodoFields.todoTitle]}", "${json[TodoFields.todoCreatedDate]}", "${json[TodoFields.todoDeadline]}", "${json[TodoFields.status]}"';
    final id = await db
        .rawInsert('INSERT INTO $tableTodos ($columns) VALUES ($values)');
    // print('database entered');
    Provider.of<TodoProvider>(con, listen: false).setTodo(todoModel);
    return todoModel.copy(id: id);
  }

  Future<TodoModel> readTodo(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableTodos,
      columns: TodoFields.values,
      where: '${TodoFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return TodoModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<TodoModel>> readAllTodos() async {
    final db = await instance.database;

    final orderBy = '${TodoFields.todoDeadline} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableTodos, orderBy: orderBy);

    final todoList = result.map((json) => TodoModel.fromJson(json)).toList();

    return todoList;
  }

  // Future<int> update(TodoModel todoModel) async {
  //   final db = await instance.database;

  //   return db.update(
  //     tableNotes,
  //     note.toJson(),
  //     where: '${NoteFields.id} = ?',
  //     whereArgs: [note.id],
  //   );
  // }

  // Future<int> delete(int id) async {
  //   final db = await instance.database;

  //   return await db.delete(
  //     tableNotes,
  //     where: '${NoteFields.id} = ?',
  //     whereArgs: [id],
  //   );
  // }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
