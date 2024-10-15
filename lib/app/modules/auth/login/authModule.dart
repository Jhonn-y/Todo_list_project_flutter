import 'package:provider/provider.dart';
import 'package:todo_list_project/app/core/modules/todoList_Module.dart';
import 'package:todo_list_project/app/modules/auth/controllers/loginController.dart';
import 'package:todo_list_project/app/modules/auth/controllers/registerController.dart';
import 'package:todo_list_project/app/modules/auth/login/login.dart';
import 'package:provider/src/change_notifier_provider.dart';
import 'package:todo_list_project/app/modules/auth/register/register.dart';

class AuthModule extends TodolistModule {
  AuthModule()
      : super(bindings: [
          ChangeNotifierProvider(create: (_) => LoginController()),
          ChangeNotifierProvider(create: (_) => RegisterController()),

          
        ], routers: {
          '/login': (context) => LoginPage(),
          '/register': (context) => Register(),
        });
}
