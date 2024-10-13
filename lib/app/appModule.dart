import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_project/app/appWidget.dart';
import 'package:todo_list_project/app/core/database/connectionFactory.dart';

class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      Provider(create:(_) => ConnectionFactory(),
      lazy: false,)
    ],
    child: const AppWidget(),);
  }
}