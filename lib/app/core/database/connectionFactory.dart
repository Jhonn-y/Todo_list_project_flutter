import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';
import 'package:todo_list_project/app/core/database/migrationFactory.dart';

class ConnectionFactory {
  
  static const _VERSION = 1;
  static const _DATABASE_NAME = 'DATABASE_EXAMPLE';

  Database? _db;

  static ConnectionFactory? _intance;

  final _lock = Lock();

  ConnectionFactory._();

  factory ConnectionFactory(){
    _intance ??= ConnectionFactory._();
  return _intance!;
  }
  Future<Database> openConnection() async{
    var databasePath = await getDatabasesPath();
    var finalPathDB = join(databasePath, "_DATABASE_NAME");
    if (_db == null){
      await _lock.synchronized(() async {
        _db = await openDatabase(finalPathDB, version: _VERSION,
        onConfigure: _onConfigure,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        onDowngrade: _onDowngrade);
      });
  }
    
  return _db!;
  }

  void closeConnection(){
    _db?.close();
    _db = null;
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute(''' PRAGMA foreign_keys = ON''',
    );
  }


  Future<void> _onCreate(Database db, int version) async {

    final batchDB = db.batch();

    final migrations = Migrationfactory().getCreateMigrations();
    for (var migration in migrations) {
      migration.create(batchDB);
    } 

    batchDB.commit();

  }


  Future<void> _onUpgrade(Database db, int oldVersion, int version) async {
    
    final batchDB = db.batch();

    final migrations = Migrationfactory().getUpdateMigrations(oldVersion);
    for (var migration in migrations) {
      migration.update(batchDB);
    } 

    batchDB.commit();

  }


  Future<void> _onDowngrade(Database db, int oldVersion, int version) async {}




}