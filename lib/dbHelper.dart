import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseConnection{

  Database? database;

  Future<Database> get asnyc async => database ??= await initDatabase();
  
  Future<Database> initDatabase() async{

    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'ContactList.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: onCreate,
    );
  }

  Future onCreate(Database db, int version) async{
    return await db.execute('''
      CREATE TABLE Contacts(
        mobileNumber VARCHAR KEY,
        firstName VARCHAR,
        lastName VARCHAR,
        email VARCHAR,
      )
    ''');
  }

  Future close() async{
    var db = database;
    db!.close();
  }

}