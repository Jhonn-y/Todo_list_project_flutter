import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_list_project/app/core/database/AdminConnection.dart';
import 'package:todo_list_project/app/core/navigator/todoListNavigator.dart';
import 'package:todo_list_project/app/modules/auth/authModule.dart';
import 'package:todo_list_project/app/modules/home/home_module.dart';
import 'package:todo_list_project/app/modules/splashPage.dart';
import 'package:todo_list_project/app/core/ui/todoListUI.dart';
import 'package:todo_list_project/app/modules/tasks/task_module.dart';

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
    WidgetsBinding.instance.addObserver(admconnetion);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(admconnetion);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo list',
      theme: TodoListUI.theme,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt', 'BR'),
      ],
      navigatorKey: TodoListNavigator.navigatorKey,
      home: const SplashPage(),
      initialRoute: '/home',
      routes: {
        ...AuthModule().routers,
        ...HomeModule().routers,
        ...TaskModule().routers,
        },
    );
  }
}