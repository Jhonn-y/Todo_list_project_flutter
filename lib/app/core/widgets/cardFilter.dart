import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_project/app/core/ui/themeExtentions.dart';
import 'package:todo_list_project/app/models/taskTodoEnum.dart';
import 'package:todo_list_project/app/models/totalTask.dart';
import 'package:todo_list_project/app/modules/auth/controllers/homeController.dart';

class CardFilter extends StatelessWidget {
  final String label;
  final TaskTodoEnum taskFilter;
  final TotalTask? totalTask;
  final bool isSelected;
  



  double _getPercentFinished() {
    final total = totalTask?.tasks ?? 0.0;
    final totalFinished = totalTask?.tasksFinished ?? 0.1;
    if (total == 0) return 0;
    final percent = (totalFinished * 100)/total;
    return percent/100;
  }

  const CardFilter(
      {super.key,
      required this.label,
      required this.taskFilter,
      this.totalTask, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final int tasksNotFinished = (totalTask?.tasks ?? 0) - (totalTask?.tasksFinished ?? 0);

    return InkWell(
      onTap: () => context.read<HomeController>().findTasks(filter: taskFilter ),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        constraints: BoxConstraints(minHeight: 120, maxWidth: 150),
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? context.primaryColor : Colors.white,
          border: Border.all(
            width: 1,
            color: Colors.grey.withOpacity(.8),
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              " ${tasksNotFinished} tarefas",
              style: context.titleStyle.copyWith(
                fontSize: 15,
                color: isSelected ? Colors.white : Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
            TweenAnimationBuilder(
              tween: Tween(
                begin: 0.0,
                end: _getPercentFinished(),
              ),
              duration: Duration(seconds: 1),
              builder: (context, value, child) {
                return LinearProgressIndicator(
                  backgroundColor: isSelected ? context.primaryColorLight : Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(isSelected ?Colors.white: context.primaryColor),
                  value: value,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
