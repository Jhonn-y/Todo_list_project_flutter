
import 'package:todo_list_project/app/models/task.dart';

class WeekTask {
  final DateTime start;
  final DateTime end;
  final List<TaskModel> tasks;

  WeekTask({required this.start, required this.end, required this.tasks});
  
}