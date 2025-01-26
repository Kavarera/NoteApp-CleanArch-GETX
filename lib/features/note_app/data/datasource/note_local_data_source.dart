import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/note_model.dart';

class NoteLocalDataSource {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'note_app_v1.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        content TEXT
      )
    ''');
  }

  Future<List<NoteModel>> getNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('notes');
    return List.generate(maps.length, (i) {
      return NoteModel.fromJson(maps[i]);
    });
  }

  Future<void> insertNote(NoteModel note) async {
    final db = await database;
    await db!.insert('notes', note.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateNote(NoteModel note) async {
    final db = await database;
    await db!
        .update('notes', note.toJson(), where: 'id = ?', whereArgs: [note.id]);
  }

  Future<void> deleteNote(int id) async {
    final db = await database;
    await db!.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
