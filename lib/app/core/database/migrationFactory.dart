import 'package:todo_list_project/app/core/database/migrations/migration_v1.dart';
import 'package:todo_list_project/app/core/database/migrations/migrations.dart';

class Migrationfactory {

  List<Migrations> getCreateMigrations() => [
    MigrationV1(),

  ];

  List<Migrations> getUpdateMigrations(int version) => [


  ];


}