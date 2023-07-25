import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';

class ContainerToBitmapConverter extends StatefulWidget {
  @override
  _ContainerToBitmapConverterState createState() =>
      _ContainerToBitmapConverterState();
}

class _ContainerToBitmapConverterState
    extends State<ContainerToBitmapConverter> {
  GlobalKey _containerKey = GlobalKey();

  Future<Uint8List?> _captureContainer() async {
    try {
      RenderRepaintBoundary boundary =
      _containerKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 1.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        return byteData.buffer.asUint8List();
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Container to Bitmap Conversion'),
      ),
      body: Center(
        child: RepaintBoundary(
          key: _containerKey,
          child: Container(
            width: 200,
            height: 200,
            color: Colors.blue,
            child: Center(
              child: Text(
                'Sample Text',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Uint8List? imageBytes = await _captureContainer();
          if (imageBytes != null) {
            // Call the function to save the bitmap to the SQLite database.
            print("ImageByte");
            print(imageBytes);
            saveToDatabase(imageBytes);
          }
        },
        child: Icon(Icons.save),
      ),
    );
  }
}

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('textdatabase.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    print("Added1");
    await db.execute('''
      CREATE TABLE textadd(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        image BLOB
      )
    ''');
  }

  Future<int> insertImage(Uint8List imageBytes) async {
    final db = await instance.database;
    print("Added2");
    return await db.insert(
      'textadd',
      {'image': imageBytes},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getImageList() async {
    final db = await instance.database;
    return await db.query('textadd');
  }
}

void saveToDatabase(Uint8List imageBytes) async {
  final dbHelper = DatabaseHelper.instance;
  await dbHelper.insertImage(imageBytes);
  print("Added3");
}

void main() => runApp(MaterialApp(
  home: Scaffold(
    body: ContainerToBitmapConverter(),
  ),
));
