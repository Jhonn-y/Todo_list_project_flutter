import 'package:flutter/material.dart';
import 'package:todo_list_project/app/core/ui/themeExtentions.dart';
import 'package:todo_list_project/app/core/widgets/tasks.dart';

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
          Text('TAREFAS DE HOJE',
          style: context.titleStyle,
          ),
          Column(
            children: [
              Tasks(),
              Tasks(),
              Tasks(),
            ],
          )
        ],
      ) );
      }
}