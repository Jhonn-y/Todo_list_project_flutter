import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_project/app/core/ui/themeExtentions.dart';
import 'package:todo_list_project/app/core/widgets/cardFilter.dart';
import 'package:todo_list_project/app/models/taskTodoEnum.dart';
import 'package:todo_list_project/app/models/totalTask.dart';
import 'package:todo_list_project/app/modules/auth/controllers/homeController.dart';

class HomeFilters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Filtros",
          style: context.titleStyle,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              CardFilter(
                label: 'HOJE',
                taskFilter: TaskTodoEnum.today,
                totalTask: context.select<HomeController, TotalTask?>((controller) => controller.todayTotalTask),
                isSelected: context.select<HomeController, TaskTodoEnum>(
                    (value) => value.filterSelected) == TaskTodoEnum.today,
              ),
              CardFilter(
                label: 'AMANHÃ',
                taskFilter: TaskTodoEnum.tomorrow,
                totalTask: context.select<HomeController, TotalTask?>((controller) => controller.tomorrowTotalTask),
                isSelected: context.select<HomeController, TaskTodoEnum>(
                    (value) => value.filterSelected) == TaskTodoEnum.tomorrow,
              ),
              CardFilter(
                label: 'SEMANA',
                taskFilter: TaskTodoEnum.week,
                totalTask: context.select<HomeController, TotalTask?>((controller) => controller.weekTotalTask),
                isSelected: context.select<HomeController, TaskTodoEnum>(
                    (value) => value.filterSelected) == TaskTodoEnum.week,
              ),
              CardFilter(
                label: 'MÊS',
                taskFilter: TaskTodoEnum.month,
                totalTask: context.select<HomeController, TotalTask?>((controller) => controller.monthTotalTask),
                isSelected: context.select<HomeController, TaskTodoEnum>(
                    (value) => value.filterSelected) == TaskTodoEnum.month,
              ),
            ],
          ),
        )
      ],
    );
  }
}
