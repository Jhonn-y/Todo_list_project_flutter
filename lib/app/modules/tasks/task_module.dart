import 'package:provider/provider.dart';
import 'package:todo_list_project/app/core/modules/todoList_Module.dart';
import 'package:todo_list_project/app/modules/auth/controllers/taskController.dart';
import 'package:todo_list_project/app/modules/tasks/taskPage.dart';
import 'package:todo_list_project/app/repo/tasks/taskRepoImpl.dart';
import 'package:todo_list_project/app/repo/tasks/tasksRepo.dart';
import 'package:todo_list_project/app/services/tasks/tasksService.dart';
import 'package:todo_list_project/app/services/tasks/tasksServiceImpl.dart';

class TaskModule extends TodolistModule {
  TaskModule()
      : super(routers: {
          '/task/create': (context) => TaskPage(
                controller: context.read(),
              ),
        }, bindings: [
          Provider<TasksRepo>(
              create: (context) =>
                  TaskRepoImpl(sqliteConnectionFactory: context.read())),
          Provider<TasksService>(
              create: (context) => TasksServiceImpl(
                    tasksService: context.read(),
                  )),
          ChangeNotifierProvider(
            create: (context) => TaskController(tasksService: context.read()),
          )
        ]);
}
