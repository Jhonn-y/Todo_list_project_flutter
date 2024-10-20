import 'package:flutter/material.dart';
import 'package:todo_list_project/app/core/widgets/todoListLogo.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Splash Screen'),
      ),
      body: const Center(
        child: TodoListLogo(),
      ),
    );
  }
}