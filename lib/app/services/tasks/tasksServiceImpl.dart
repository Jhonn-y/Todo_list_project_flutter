

import 'package:todo_list_project/app/repo/tasks/tasksRepo.dart';
import 'package:todo_list_project/app/services/tasks/tasksService.dart';

class TasksServiceImpl implements TasksService{
    final TasksRepo _tasksRepo;

  TasksServiceImpl({required TasksRepo tasksService}) : _tasksRepo = tasksService;

  @override
  Future<void> save(DateTime date, String description)  => _tasksRepo.save(date, description);
  
}