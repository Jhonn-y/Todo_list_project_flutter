import 'package:todo_list_project/app/models/task.dart';

abstract interface class TasksRepo {

  Future<void> save(DateTime date, String description);
  Future<List<TaskModel>> findByDate(DateTime start, DateTime end); 
  Future<void> checkOrUncheckTask(TaskModel task);
  Future<void> removeById(int id);
  Future<void> removeAllTasks();
}