import 'package:provider/provider.dart';
import 'package:todo_list_project/app/core/modules/todoList_Module.dart';
import 'package:todo_list_project/app/modules/auth/controllers/homeController.dart';
import 'package:todo_list_project/app/modules/home/home.dart';
import 'package:todo_list_project/app/repo/tasks/taskRepoImpl.dart';
import 'package:todo_list_project/app/repo/tasks/tasksRepo.dart';
import 'package:todo_list_project/app/services/tasks/tasksService.dart';
import 'package:todo_list_project/app/services/tasks/tasksServiceImpl.dart';


class HomeModule extends TodolistModule{
  HomeModule():super(
    bindings: [
      Provider<TasksRepo>(create: (context) => TaskRepoImpl(sqliteConnectionFactory: context.read())),
      Provider<TasksService>(create: (context) => TasksServiceImpl(tasksService: context.read(),)),
      ChangeNotifierProvider(create: (context) => HomeController(tasksService: context.read()))
    ],
    routers: {
      '/home': (context) =>  Home(homeController: context.read(),),
    }
  );
      
}