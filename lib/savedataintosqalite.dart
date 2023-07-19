


import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';

class savedataintosqalite extends StatefulWidget {
  const savedataintosqalite({super.key});

  @override
  State<savedataintosqalite> createState() => _savedataintosqaliteState();
}
TextEditingController namecontroller = TextEditingController();
TextEditingController emailcontroller = TextEditingController();
TextEditingController dobcontroller = TextEditingController();
class _savedataintosqaliteState extends State<savedataintosqalite> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    home: Scaffold(
      appBar: AppBar(
        title: Text("Store Data"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 1),
              padding: EdgeInsets.all(10),
              child: TextField(
                keyboardType: TextInputType.text,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Enter Name',
                ),
                controller: namecontroller,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 1),
              padding: EdgeInsets.all(10),
              child: TextField(
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Enter Email',
                ),
                controller: emailcontroller,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 1),
              padding: EdgeInsets.all(10),
              child: TextField(
                keyboardType: TextInputType.datetime,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'DOB',
                  hintText: 'Enter date of birth',
                ),
                controller: dobcontroller,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 1),
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: (){
                  if(namecontroller.text==""||namecontroller.text==null||emailcontroller.text==null||emailcontroller.text==""||
                      dobcontroller.text==null||dobcontroller.text=="")
                    {
                      print("Enter all information");

                    }
                  else
                    {
print("gettt");
                    }
                },
                child: Text("Save it"),
              ),
            )
          ],
        ),
      ),
    ),
    );
  }
}

class Details{
  var  id ;
  var  name,email,dob;
  Details({this.id,this.name,this.email,this.dob});
  Map<String,dynamic> toMao()
  {
    return{
      "id":id,
      "name":name,
      "email":email,
      "dob":dob,
    };
  }

  factory Details.fromMap(Map<String,dynamic>map)
  {
    return Details(
      id: map["id"],
      name: map["name"],
      email: map["email"],
      dob: map["dob"],
    );
  }

}
/*
lass DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'user_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        dob TEXT
      )
    ''');
  }

  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert('users', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<User>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (index) {
      return User.fromMap(maps[index]);
    });
  }
}
 */