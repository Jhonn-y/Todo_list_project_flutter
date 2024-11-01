import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_project/app/core/ui/themeExtentions.dart';
import 'package:todo_list_project/app/modules/auth/controllers/taskController.dart';

class CalendarButton extends StatelessWidget {

  CalendarButton({ super.key });
  final dateFormat = DateFormat('dd/MM/y');

  @override
  Widget build(BuildContext context) {
      return InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () async {
          var lastDate = DateTime.now();
          lastDate = lastDate.add(Duration(days: 5 * 365));

          final DateTime? selectedDate = await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: lastDate); 

          context.read<TaskController>().selectedDate = selectedDate;
        },

        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.today,
              color: Colors.grey,),
              SizedBox(
                width: 10,
              ),
              Selector<TaskController, DateTime?>(
                selector: (context, controller) => controller.selectedDate,
                builder: (context, selectedDate, child) {
                  if(selectedDate != null){
                    return Text(
                      dateFormat.format(selectedDate),
                      style: context.titleStyle,
                    );
                  }
                  else{
                    return Text(
                'SELECIONE UMA DATA',
                style: context.titleStyle,
              );
                  }
                },
              )
            ],
          )
        ),
      );
  }
}