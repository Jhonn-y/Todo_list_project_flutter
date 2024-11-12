
import 'package:todo_list_project/app/core/database/connectionFactory.dart';
import 'package:todo_list_project/app/models/task.dart';
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

  @override
  Future<List<TaskModel>> findByDate(DateTime start, DateTime end) async {
    final startDate = DateTime(start.year,start.month,start.day,0,0,0,);
    final endDate = DateTime(end.year,end.month,end.day,23,59,59,);

    final conn = await _sqliteConnectionFactory.openConnection();
    final result = await conn.rawQuery('''
    SELECT * FROM todo
    WHERE date_time between ? and ?
    ORDER BY date_time
''', [startDate.toIso8601String(),
endDate.toIso8601String()]);

    return result.map((e) => TaskModel.loadFromDB(e)).toList();
  }
  
  @override
  Future<void> checkOrUncheckTask(TaskModel task) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final finished = task.isFinished ? 1 : 0;

    await conn.rawUpdate('''
    UPDATE todo
    SET ended = ? 
    WHERE id = ?
    ''', [finished,task.id]);
  }
  
}