
import 'package:todo_list_project/app/core/database/connectionFactory.dart';
import 'package:todo_list_project/app/repo/tasks/tasksRepo.dart';

class TaskRepoImpl implements TasksRepo {
  final ConnectionFactory _sqliteConnectionFactory;

  TaskRepoImpl({
    required ConnectionFactory sqliteConnectionFactory,
  }) : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<void> save(DateTime date, String description) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    await conn.insert('todo', {
      'id': null,
      'description': description,
      'date_time': date.toIso8601String(),
      'ended': 0
    });
  }
  
}