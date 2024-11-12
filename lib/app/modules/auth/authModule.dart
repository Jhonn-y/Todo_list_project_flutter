import 'package:provider/provider.dart';
import 'package:todo_list_project/app/core/modules/todoList_Module.dart';
import 'package:todo_list_project/app/modules/auth/controllers/homeController.dart';
import 'package:todo_list_project/app/modules/auth/controllers/loginController.dart';
import 'package:todo_list_project/app/modules/auth/login/login.dart';
import 'package:todo_list_project/app/modules/auth/register/register.dart';
import 'package:todo_list_project/app/modules/auth/controllers/registerController.dart';
import 'package:todo_list_project/app/modules/home/home.dart';

class AuthModule extends TodolistModule {
  AuthModule()
      : super(bindings: [
          ChangeNotifierProvider(create: (context) => HomeController(tasksService: context.read())),
          ChangeNotifierProvider(create: (context) => LoginController(userService: context.read())),
          ChangeNotifierProvider(create: (context) => RegisterController(userService: context.read())),
          
        ], routers: {
          '/home': (context) =>  Home(homeController: context.read()),
          '/login': (context) => const LoginPage(),
          '/register': (context) => const Register(),
        });
}
