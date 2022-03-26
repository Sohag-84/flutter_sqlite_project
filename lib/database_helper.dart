
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';



class DatabaseHelper{
  static final _dbName = "myDatabase.db";
  static final _dbVersion = 1;
  static final _tableName = "myTable";

  static final columnId = "_id";
  static final comlumnName = "name";

  //making it in a single tone class
   DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();


  static Database? _database;
    Future<Database?> get database async{
      if(_database !=null){
        return _database;
      }else{
        _database = await initiateDatabase();
      }
      return _database;
    }

// this opens the database (and creates it if it doesn't exist)
  initiateDatabase() async{
      Directory directory = await getApplicationDocumentsDirectory();//in mobile system here all the local data is store
      String path = join(directory.path,_dbName);
      return await openDatabase(path,version: _dbVersion,onCreate: _onCreate); //that means go to the directory and open database(dbName)
  }

  // SQL code to create the database table
  Future<void> _onCreate(Database db, int version) async{
      await db.execute(
        ''' 
        CREATE TABLE $_tableName (
          $columnId INTEGER PRIMARY KEY,
          $comlumnName TEXT NOT NULL
        )
        '''
      );
  }
  //insert value int the table
  Future<int> insert(Map<String,dynamic> row) async{
      Database? db = await instance.database;
      return await db!.insert(_tableName, row);
  }
  Future<List<Map<String,dynamic>>> queryAll() async{
      Database? db = await instance.database;
      return await db!.query(_tableName);
  }
  //for updating database
  Future<int> update(Map<String,dynamic> row) async{
      Database? db = await instance.database;
      int id = row[columnId];
      return await db!.update(_tableName, row,where: '$columnId = ?',whereArgs: [id]);
  }
  //for delete
  Future<int> delete(int id) async{
      Database? db = await instance.database;
      return await db!.delete(_tableName,where: '$columnId = ?',whereArgs: [id]);
  }
}

