import 'package:flutter/material.dart';
import 'package:todo_list_project/app/core/ui/themeExtentions.dart';

class CardFilter extends StatefulWidget {

  const CardFilter({ super.key });

  @override
  State<CardFilter> createState() => _CardFilterState();
}

class _CardFilterState extends State<CardFilter> {

  @override
  Widget build(BuildContext context) {
      return Container(
        constraints: BoxConstraints(minHeight: 120, maxWidth: 150),
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: context.primaryColor,
          border: Border.all(
            width: 1,
            color: Colors.grey.withOpacity(.8),
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(" 10 tarefas",
            style: context.titleStyle.copyWith(
              fontSize: 15,
              color: Colors.white,
            ),),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text('HOJE',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),),
            ),
            LinearProgressIndicator(
              backgroundColor: context.primaryColorLight,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              value: 0.4,
            )
            
          ],
        ),
      );
  }
}