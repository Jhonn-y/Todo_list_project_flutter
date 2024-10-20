import 'package:flutter/material.dart';
import 'package:todo_list_project/app/core/database/connectionFactory.dart';

class AdminConnection with WidgetsBindingObserver{

  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    final connection = ConnectionFactory();
    switch(state){
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        connection.closeConnection();
        break;  
      default:
        print("Unknown state");
        break;  
    }
    
    
    super.didChangeAppLifecycleState(state);

  }


}