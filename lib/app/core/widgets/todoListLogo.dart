import 'package:flutter/material.dart';
import 'package:todo_list_project/app/core/ui/themeExtentions.dart';

class TodoListLogo extends StatelessWidget {
  const TodoListLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('Assets/logo.png', height: 200,),
        Text('Todo List', style: context.textTheme.headlineMedium),

      ],
    );
  }
}