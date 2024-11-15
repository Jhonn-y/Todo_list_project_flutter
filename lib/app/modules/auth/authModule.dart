import 'package:provider/provider.dart';
import 'package:todo_list_project/app/core/modules/todoList_Module.dart';
import 'package:todo_list_project/app/modules/auth/controllers/loginController.dart';
import 'package:todo_list_project/app/modules/auth/login/login.dart';
import 'package:todo_list_project/app/modules/auth/register/register.dart';
import 'package:todo_list_project/app/modules/auth/controllers/registerController.dart';

class AuthModule extends TodolistModule {
  AuthModule()
      : super(bindings: [
          ChangeNotifierProvider(create: (context) => LoginController(userService: context.read())),
          ChangeNotifierProvider(create: (context) => RegisterController(userService: context.read())),
          
        ], routers: {
          '/login': (context) => const LoginPage(),
          '/register': (context) => const Register(),
        });
}
