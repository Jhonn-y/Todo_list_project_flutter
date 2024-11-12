import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_project/app/core/ui/themeExtentions.dart';
import 'package:todo_list_project/app/models/taskTodoEnum.dart';
import 'package:todo_list_project/app/modules/auth/controllers/homeController.dart';

class HomeWeekFilter extends StatelessWidget {

  const HomeWeekFilter({ super.key });

  @override
  Widget build(BuildContext context) {
      return Visibility(
        visible: context.select<HomeController,bool>((controller) => controller.filterSelected == TaskTodoEnum.week),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text('Dia da Semana',
            style: context.titleStyle,),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 95,
              child:Selector<HomeController,DateTime>(builder: (_, value, __) {
                return  DatePicker(value,
              locale: 'pt_BR',
              initialSelectedDate: value,
              selectionColor: context.primaryColor,
              selectedTextColor: Colors.white,
              daysCount: 7,
              monthTextStyle: TextStyle(fontSize: 8),
              dayTextStyle: TextStyle(fontSize: 13),
              dateTextStyle: TextStyle(fontSize: 13),
              onDateChange: (date){
                context.read<HomeController>().filterByDay(date);
              },);
              }, selector: (context, controller) => controller.initialDateOfWeek ?? DateTime.now(),)
              
            )
          ],
        ),
      );
  }
}