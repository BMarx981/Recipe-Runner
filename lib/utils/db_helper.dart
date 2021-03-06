import 'dart:io';

import 'package:path/path.dart';
import 'package:recipe_writer/models/event.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipe_writer/models/recipe.dart';

class DatabaseHelper {
  static final _databaseName = "CoboDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'recipes';
  static final plannerTable = 'planner';

  static final plannerId = 'id';
  static final plannerDate = 'date';
  static final plannerName = 'name';
  static final plannerIsDone = 'isDone';

  static final columnId = 'id';
  static final columnName = 'name';
  static final columnURL = 'url';
  static final columnImageURL = 'image';
  static final columnDescription = 'description';
  static final columnIngredients = 'ingredients';
  static final columnDirections = 'directions';
  final String delimiter = '||?';

  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT NOT NULL,
            $columnDescription TEXT NOT NULL,
            $columnDirections TEXT NOT NULL,
            $columnIngredients TEXT NOT NULL,
            $columnImageURL TEXT NOT NULL,
            $columnURL TEXT NOT NULL
          )
          ''');
    await db.execute('''
            CREATE TABLE $plannerTable (
            $plannerId INTEGER PRIMARY KEY AUTOINCREMENT,
            $plannerDate TEXT NOT NULL,
            $plannerName TEXT NOT NULL,
            $plannerIsDone INTEGER
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int outputId = 0;
    try {
      outputId = await db.insert(table, row);
    } catch (e) {
      print('Error found with $e');
    }
    return outputId;
  }

  Future<int> insertEvent(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int outputId = 0;
    try {
      outputId = await db.insert(plannerTable, row);
    } catch (e) {
      print('Error found with $e');
    }
    return outputId;
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    // List<Map<String, dynamic>> map = await db.query(table);
    return await db.query(table);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> insertRow(Recipe recipe) async {
    Database db = await instance.database;
    return await db.insert(table, recipe.toMapForDb());
  }

  Future<int> insertPlannerRow(Event event) async {
    Database db = await instance.database;
    return await db.insert(plannerTable, event.toMapForDB());
  }

  Future<int> deletePlannerRow(int id) async {
    Database db = await instance.database;
    return await db
        .delete(plannerTable, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getPlannerTable() async {
    Database db = await instance.database;
    return await db.query(plannerTable);
  }
}
