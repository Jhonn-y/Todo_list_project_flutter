import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_project/app/models/task.dart';
import 'package:todo_list_project/app/modules/auth/controllers/homeController.dart';

class Tasks extends StatelessWidget {
  final TaskModel taskModel;
  final dateFormat = DateFormat('dd/MM/y');
  Tasks({super.key, required this.taskModel });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 10),
              blurRadius: 10,
            ),
          ]),
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Checkbox(value: taskModel.isFinished, onChanged: (value) {
          context.read<HomeController>().checkOrUncheckTask(taskModel);
        }),
        title: Text(
          taskModel.description,
          style: TextStyle(
            decoration: taskModel.isFinished ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          dateFormat.format(taskModel.dateTime),
          style: TextStyle(
            decoration: taskModel.isFinished ? TextDecoration.lineThrough : null,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(width: 1),
        ),
      ),
    );
  }
}
