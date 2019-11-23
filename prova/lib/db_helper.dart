import 'dart:async';
import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DbHelper {
  static final _dbName = "ArmaDB.db";
  static final _dbVersion = 2;

  //transforma a classe em Singleton para gerenciar
  //conexões do Banco
  DbHelper._privateConstructor();
  static final DbHelper instance = DbHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDatabase();
    return  _database;
  }

  initDatabase() async {
    Directory dbDirectory = await getApplicationDocumentsDirectory();
    String path = join(dbDirectory.path, _dbName); //monta o caminho da DB
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE ARMA ( 
                          ID INTEGER PRIMARY KEY, 
                          MARCA TEXT,
                          MODELO TEXT,
                          ORIGEM TEXT,
                          COR TEXT,
                          CALIBRE TEXT)''');
  }

  //METODO INSERT
  Future <int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert("ARMA", row);
  }

  //METODO SELECT
  Future <List<Map<String, dynamic>>> getAll() async {
    Database db = await instance.database;
    return await db.query("ARMA");
  }

  //GET ID
  Future<List<Map<String, dynamic>>> getId(int id) async {
    Database db = await instance.database;
    //var response = 
    return await db.query("ARMA", where: "ID = ?", whereArgs: [id]);
    //return response.first;
  }


  //SELECT LAST
  Future <Map<String, dynamic>> getLast() async {
    Database db = await instance.database;
    var arma = await db.query("ARMA", limit: 1, orderBy: "ID DESC");
    return arma.first;
  }

  //DELETE ALL
  Future <int> removeAll() async {
    Database db = await instance.database;
    return await db.delete("ARMA");
  }

  //DELETE LAST
  Future <int> removeLast(int id) async {
    Database db = await instance.database;
    return await db.delete("ARMA", where: 'ID= ?', whereArgs: [id]);
  }  

  //UPDATE
  Future<int> update(Map<String, dynamic> row, int id) async {
    Database db = await instance.database;
    return await db.update("ARMA", row, where: 'ID = ?', whereArgs: [id]);
  }
}
