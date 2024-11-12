
import 'package:todo_list_project/app/models/task.dart';

class MonthTask {
  final DateTime start;
  final DateTime end;
  final List<TaskModel> tasks;

  MonthTask({required this.start, required this.end, required this.tasks});
  
}