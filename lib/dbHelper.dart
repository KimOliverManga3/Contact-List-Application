import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'functions.dart';

class DatabaseConnection{

  Database? _database;

  Future<Database> get database async => _database ??= await initDatabase();
  
  Future<Database> initDatabase() async{

    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'contact_list.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: onCreate,
    );
    return _database!;
  }

  Future<void> onCreate(Database db, int version) async{
    await db.execute('CREATE TABLE contacts(phoneNumber VARCHAR PRIMARY KEY, name VARCHAR, emailAddress VARCHAR)');
  }

  Future<void> insertContact(Functionalities contact) async{ 
    var db = await database;
    await db.insert("contacts", contact.toMap());
  }

  Future<List<Functionalities>> getContacts() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query('contacts');

    return List.generate(maps.length, (i) {
        return Functionalities(
          phoneNumber: maps[i]['phoneNumber'],
          name: maps[i]['name'],
          emailAddress: maps[i]['emailAddress'],
        );
    });

  }

  getContacts2() async {
    final db = await database;
    final  maps = await db.query('contacts');
    inspect(maps);
  }

  Future close() async{
    var db = await database;
    db.close();
  }

}