import 'package:todo_list_project/app/models/monthTask.dart';
import 'package:todo_list_project/app/models/task.dart';
import 'package:todo_list_project/app/models/weekTask.dart';
import 'package:todo_list_project/app/repo/tasks/tasksRepo.dart';
import 'package:todo_list_project/app/services/tasks/tasksService.dart';

class TasksServiceImpl implements TasksService{
    final TasksRepo _tasksRepo;

  TasksServiceImpl({required TasksRepo tasksService}) : _tasksRepo = tasksService;

  @override
  Future<void> save(DateTime date, String description)  => _tasksRepo.save(date, description);

  @override
  Future<List<TaskModel>> getToday() {
    return _tasksRepo.findByDate(DateTime.now(), DateTime.now());
  }

  @override
  Future<List<TaskModel>> getTomorrow() {
    var tomorrowDate = DateTime.now().add(Duration(days: 1));
  
    return _tasksRepo.findByDate(tomorrowDate, tomorrowDate);

  }

  @override
  Future<WeekTask> getWeek() async {
  final today = DateTime.now();
  var startFilter = DateTime(today.year,today.month,today.day,0,0,0);
  DateTime endFilter;

  if(startFilter.weekday != DateTime.monday){
    startFilter = startFilter.subtract(Duration(days: (startFilter.weekday - 1)));

  }
  
  endFilter = startFilter.add(Duration(days: 7));
  final tasks = await _tasksRepo.findByDate(startFilter, endFilter);
  return WeekTask(start: startFilter, end: endFilter, tasks: tasks);
  
  }

  @override
  Future<MonthTask> getMonth() async {
  final today = DateTime.now();
  var startFilter = DateTime(today.year,today.month,1,0,0,0);
  DateTime endFilter;
  
  endFilter = DateTime(today.year, today.month + 1, 0, 23, 59, 59);
  final tasks = await _tasksRepo.findByDate(startFilter, endFilter);
  return MonthTask(start: startFilter, end: endFilter, tasks: tasks);
  }
  
  @override
  Future<void> checkOrUncheckTask(TaskModel task) {
    return _tasksRepo.checkOrUncheckTask(task);
  }

  
}