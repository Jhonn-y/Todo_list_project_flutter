import 'package:flutter/material.dart';
import 'package:todo_list_project/app/core/notifier/defaultListener.dart';
import 'package:todo_list_project/app/core/ui/themeExtentions.dart';
import 'package:todo_list_project/app/core/widgets/calendarbutton.dart';
import 'package:todo_list_project/app/core/widgets/todoListField.dart';
import 'package:todo_list_project/app/modules/auth/controllers/taskController.dart';
import 'package:validatorless/validatorless.dart';

class TaskPage extends StatefulWidget {
  final TaskController _controller;

  TaskPage({
    super.key,
    required TaskController controller,
  }) : _controller = controller;

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final _descriptionEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  
  @override
  void initState() {
    super.initState();
    DefaultListener(changeNotifier: widget._controller,).listener(succesCallback: (notifier, listenerInstance) {
      listenerInstance.dispose();
      Navigator.of(context).pop();
    }, context: context);
  }

  @override
  void dispose() {
    _descriptionEC.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: context.primaryColor,
            onPressed: () {
              final validation = _formKey.currentState?.validate() ?? false;

              if(validation){
                widget._controller.save(_descriptionEC.text);
              }

            },
            label: Text(
              'Adicionar tarefa',
              style: context.titleStyle.copyWith(color: Colors.white),
            )),
        body: Form(
            key: _formKey,

            child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Criar Tarefa',
                  style: context.titleStyle.copyWith(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TodoListField(label: '',
              controller: _descriptionEC,
              validator: Validatorless.required('Descrição obrigatória'),),
              SizedBox(
                height: 30,
              ),
              CalendarButton(),
            ],
          ),
        )));
  }
}
