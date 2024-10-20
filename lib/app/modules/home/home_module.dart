import 'package:todo_list_project/app/core/modules/todoList_Module.dart';
import 'package:todo_list_project/app/modules/home/home.dart';

class HomeModule extends TodolistModule{
  HomeModule():super(
    // bindings: [],
    routers: {
      '/home': (context) => const Home(),
    }
  );
      
}