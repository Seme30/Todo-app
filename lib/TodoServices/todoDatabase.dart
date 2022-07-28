import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/TodoServices/todoModel.dart';

class TodoDatabase {
  static final TodoDatabase instance = TodoDatabase._init();

  static Database? _database;

  TodoDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
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
  }

  Future<TodoModel> create(TodoModel todoModel) async {
    final db = await instance.database;
    final json = {
      'todoTitle': todoModel.todoTitle,
      'todoCreatedDate': todoModel.todoCreatedDate,
      'todoDeadline': todoModel.todoDeadline,
      'status': todoModel.status
    };
    final columns =
        '${TodoFields.todoTitle}, ${TodoFields.todoCreatedDate}, ${TodoFields.todoDeadline}, ${TodoFields.status}';
    final values =
        '${json[TodoFields.todoTitle]}, ${json[TodoFields.todoCreatedDate]}, ${json[TodoFields.todoDeadline]}, ${json[TodoFields.status]}';
    final id = await db
        .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

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

    return result.map((json) => TodoModel.fromJson(json)).toList();
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
