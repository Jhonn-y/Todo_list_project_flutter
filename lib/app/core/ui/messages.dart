
import 'package:flutter/material.dart';
import 'package:todo_list_project/app/core/ui/themeExtentions.dart';

class Messages {
  final BuildContext context;
  Messages._(this.context);

  factory Messages.of(BuildContext context){
    return Messages._(context);
  }

  void showError(String message){
    showMessage(message, Colors.red);
  }

  void showInfo(String message){
    showMessage(message, context.primaryColor);
  }

  void showMessage(String message, Color color){
    ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: color,
          ),
        );
  }

}