
import 'package:todo_list_project/app/models/monthTask.dart';
import 'package:todo_list_project/app/models/task.dart';
import 'package:todo_list_project/app/models/weekTask.dart';

abstract class TasksService {
  Future<void> save(DateTime date, String description);
  Future<List<TaskModel>> getToday();
  Future<List<TaskModel>> getTomorrow();
  Future<WeekTask> getWeek();
  Future<MonthTask> getMonth();
  Future<void> checkOrUncheckTask(TaskModel task);
}