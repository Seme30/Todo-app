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
    const idType = 'INTEGER PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableTodos ( 
  ${TodoFields.id} $idType, 
  ${TodoFields.todoTitle} $textType,
  ${TodoFields.todoCreatedDate} $textType,
  ${TodoFields.todoDeadline} $textType,
  ${TodoFields.status} $textType
  )
''');
  }

  Future<TodoModel> createTodo(TodoModel todoModel, BuildContext con) async {
    final db = await instance.database;
    String deadline = todoModel.todoDeadline.toString();
    String createdDate = todoModel.todoCreatedDate.toString();
    final json = {
      TodoFields.id: todoModel.id,
      TodoFields.todoTitle: todoModel.todoTitle,
      TodoFields.todoCreatedDate: createdDate,
      TodoFields.todoDeadline: deadline,
      TodoFields.status: todoModel.status
    };
    // print('create: before insert' + todoModel.id.toString());
    // print('create: date' + todoModel.todoCreatedDate.toString());
    // print('create: deadline' + todoModel.todoDeadline.toString());
    // print('create: ' + todoModel.todoTitle.toString());
    // print('create: ' + todoModel.status.toString());
    const columns =
        '${TodoFields.id}, ${TodoFields.todoTitle}, ${TodoFields.todoCreatedDate}, ${TodoFields.todoDeadline}, ${TodoFields.status}';
    final values =
        '${json[TodoFields.id]},"${json[TodoFields.todoTitle]}", "${json[TodoFields.todoCreatedDate]}", "${json[TodoFields.todoDeadline]}", "${json[TodoFields.status]}"';
    final id = await db
        .rawInsert('INSERT INTO $tableTodos ($columns) VALUES ($values)');
    // print('id: ' + id.toString());
    // print('create: ' + todoModel.id.toString());
    // print('create: date' + todoModel.todoCreatedDate.toString());
    // print('create: deadline' + todoModel.todoDeadline.toString());
    // print('create: ' + todoModel.todoTitle.toString());
    // print('create: ' + todoModel.status.toString());

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
      final json = maps.first;
      String key = json['todoDeadline'] as String;
      String key2 = json['todoCreatedDate'] as String;
      DateTime dateTime = DateTime.parse(key);
      DateTime dateTime2 = DateTime.parse(key2);
      return TodoModel(
          id: json['id'] as int,
          todoTitle: json['todoTitle'] as String,
          todoCreatedDate: dateTime2,
          todoDeadline: dateTime,
          status: json['status'] as String);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<TodoModel>> readAllTodos() async {
    final db = await instance.database;

    const orderBy = '${TodoFields.todoDeadline} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableTodos, orderBy: orderBy);

    final todoList = result.map((json) {
      String key = json['todoDeadline'] as String;
      String key2 = json['todoCreatedDate'] as String;
      DateTime dateTime = DateTime.parse(key);
      DateTime dateTime2 = DateTime.parse(key2);
      return TodoModel(
          id: json['id'] as int,
          todoTitle: json['todoTitle'] as String,
          todoCreatedDate: dateTime2,
          todoDeadline: dateTime,
          status: json['status'] as String);
    }).toList();

    // print('read: ' + todoList[0].id.toString());
    // print('read: date' + todoList[0].todoCreatedDate.toString());
    // print('read: deadline' + todoList[0].todoDeadline.toString());
    // print('read: ' + todoList[0].todoTitle.toString());
    // print('read: ' + todoList[0].status.toString());
    return todoList;
  }

  Future<int> update(TodoModel todoModel) async {
    final db = await instance.database;
    String deadline = todoModel.todoDeadline.toString();
    String createdDate = todoModel.todoCreatedDate.toString();
    final json = {
      TodoFields.id: todoModel.id,
      TodoFields.todoTitle: todoModel.todoTitle,
      TodoFields.todoCreatedDate: createdDate,
      TodoFields.todoDeadline: deadline,
      TodoFields.status: todoModel.status
    };
    return db.update(
      tableTodos,
      json,
      where: '${TodoFields.id} = ?',
      whereArgs: [todoModel.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableTodos,
      where: '${TodoFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
