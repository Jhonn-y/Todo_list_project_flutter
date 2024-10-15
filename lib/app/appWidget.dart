import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_project/app/core/database/AdminConnection.dart';
import 'package:todo_list_project/app/modules/auth/login/authModule.dart';
import 'package:todo_list_project/app/modules/splashPage.dart';
import 'package:todo_list_project/app/ui/todoListUI.dart';

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
    FirebaseAuth auth = FirebaseAuth.instance;
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
      theme: TodoListUI.theme,
      home: SplashPage(),
      routes: {
        ...AuthModule().routers,
        
        },
    );
  }
}