import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';



class savetext extends StatefulWidget {
  const savetext({super.key});

  @override
  State<savetext> createState() => _savetextState();
}

class _savetextState extends State<savetext> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TextSaverScreen(),
    );
  }
}

class TextSaverScreen extends StatefulWidget {
  @override
  _TextSaverScreenState createState() => _TextSaverScreenState();
}

class _TextSaverScreenState extends State<TextSaverScreen> {
  final dbHelper = DatabaseHelper();

  void saveTextToDatabase(String text) async {
    await dbHelper.insertText(text);
    print('$text Text saved to the database!');
  }
  void retrieveAllText() async {
    final allText = await dbHelper.getAllText();
    print('All text in the database:');
    allText.forEach((row) {
      print(row['text']);
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      retrieveAllText();
    });
    super.initState();
  }
  TextEditingController controller= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('SQLite in Flutter'),
        ),
        body: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Enter Name',
                  hintText: 'Enter Your Name'
              ),
              controller: controller,
            ),
            ElevatedButton(
              onPressed: () {
                saveTextToDatabase(controller.text);
                retrieveAllText();
              },
              child: Text('Save Text'),
            )
          ],

        ),
      ),
    );
  }
}

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  DatabaseHelper.internal();

  Future<Database> initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'textdatabase.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE textadd(id INTEGER PRIMARY KEY, text TEXT)');
  }

  Future<int> insertText(String text) async {
    final dbClient = await db;
    return await dbClient!.insert('textadd', {'text': text});
  }
  Future<List<Map<String, dynamic>>> getAllText() async {
    final dbClient = await db;
    return await dbClient!.query('textadd');
  }
}