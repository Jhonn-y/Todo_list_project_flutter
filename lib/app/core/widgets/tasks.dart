import 'package:flutter/material.dart';

class Tasks extends StatelessWidget {
  const Tasks({super.key});

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
        leading: Checkbox(value: true, onChanged: (value) {}),
        title: Text(
          'Descrição',
          style: TextStyle(
            decoration: true ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          '10/08/2024',
          style: TextStyle(
            decoration: true ? TextDecoration.lineThrough : null,
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
