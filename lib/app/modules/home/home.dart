
import 'package:flutter/material.dart';
import 'package:todo_list_project/app/core/ui/my_flutter_app_icons.dart';
import 'package:todo_list_project/app/core/ui/themeExtentions.dart';
import 'package:todo_list_project/app/core/widgets/homeDrawer.dart';
import 'package:todo_list_project/app/core/widgets/homeFilters.dart';
import 'package:todo_list_project/app/core/widgets/homeHeader.dart';
import 'package:todo_list_project/app/core/widgets/homeTask.dart';
import 'package:todo_list_project/app/core/widgets/homeWeekFilter.dart';
import 'package:todo_list_project/app/modules/tasks/task_module.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  void _goToTask(BuildContext context){
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 400),
        transitionsBuilder:(context, animation, secondaryAnimation, child) {
          animation = CurvedAnimation(parent: animation, curve: Curves.easeInQuad);
          return ScaleTransition(scale: animation,
          alignment: Alignment.bottomRight,
          child: child,);
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return TaskModule().getPage('/task/create', context);
        },
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: context.primaryColor),
        backgroundColor: const Color.fromARGB(255, 218, 218, 218),
        elevation: 0,
        actions: [
          PopupMenuButton(itemBuilder: (_) => [
            PopupMenuItem<bool>(child: Text('Mostrar tarefas concluidas'),),
            PopupMenuItem<bool>(child: Text('Mostrar tarefas pendentes'),),
            
          ], icon: Icon(MyFlutterApp.filter_list),)
        ],
        title: const Text('Home'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.primaryColor,
        onPressed: () => _goToTask(context),
      child: Icon(Icons.add, color: Colors.white,),),
      drawer: HomeDrawer(),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
            minWidth: constraints.maxWidth,
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeHeader(),
                  HomeFilters(),
                  HomeWeekFilter(),
                  HomeTask(),

                ],
              ),
            ),
          ),),
        );
      },)
    );
  }
}