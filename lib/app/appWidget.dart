import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_project/app/core/database/AdminConnection.dart';
import 'package:todo_list_project/app/modules/auth/controllers/loginController.dart';
import 'package:todo_list_project/app/modules/auth/login/authModule.dart';
import 'package:todo_list_project/app/modules/auth/login/login.dart';
import 'package:todo_list_project/app/modules/splashPage.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final admconnetion = AdminConnection();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(admconnetion);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(admconnetion);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo list',
      home: SplashPage(),
      routes: {
        ...AuthModule().routers,
        
        },
    );
  }
}