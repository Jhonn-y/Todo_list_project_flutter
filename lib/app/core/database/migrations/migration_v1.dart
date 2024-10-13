import 'package:sqflite_common/sqlite_api.dart';
import 'package:todo_list_project/app/core/database/migrations/migrations.dart';

class MigrationV1 implements Migrations{
  @override
  void create(Batch batch) {
    batch.execute('''
    CREATE TABLE IF NOT EXISTS todo (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      description VARCHAR(500),
      date_time DATETIME,
      ended INTEGER)''');
  
  }

  @override
  void update(Batch batch) {
    // TODO: implement update
  }
  
}