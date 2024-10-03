import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'chat_model.dart';

class ChatDatabase {
  static final ChatDatabase instance = ChatDatabase._init();

  static Database? _database;

  ChatDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('chat.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const messageTable = '''
    CREATE TABLE messages(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      role TEXT NOT NULL,
      content TEXT NOT NULL
    )
    ''';

    await db.execute(messageTable);
  }

  Future<int> insertMessage(ChatMessage message) async {
    final db = await instance.database;
    return await db.insert('messages', message.toJson());
  }

  Future<List<ChatMessage>> fetchMessages() async {
    final db = await instance.database;
    final result = await db.query('messages');

    return result.map((json) => ChatMessage.fromJson(json)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
