import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_project/app/core/ui/themeExtentions.dart';
import 'package:todo_list_project/app/core/widgets/cardFilter.dart';
import 'package:todo_list_project/app/core/widgets/tasks.dart';
import 'package:todo_list_project/app/models/task.dart';
import 'package:todo_list_project/app/models/taskTodoEnum.dart';
import 'package:todo_list_project/app/modules/auth/controllers/homeController.dart';

class HomeTask extends StatelessWidget {

  const HomeTask({ super.key });

  @override
  Widget build(BuildContext context) {
      return Expanded(child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Selector<HomeController,String>(
            selector: (context, controller) {
              return controller.filterSelected.description;
            },
            builder: (context, value, child) {
              return Text('TAREFAS $value',
              style: context.titleStyle,
          );
            },
          ),
          Column(
              children: context.select<HomeController, List<TaskModel>>((controller) => controller.filteredtasks)
              .map((t) => Tasks(taskModel: t,))
              .toList(),
          )
        ],
      ) );
      }
}