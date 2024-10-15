import 'package:flutter/material.dart';
import 'package:todo_list_project/app/ui/themeExtentions.dart';
import 'package:todo_list_project/app/widgets/todoListField.dart';
import 'package:todo_list_project/app/widgets/todoListLogo.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Go back',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text(
              'and login',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: ClipOval(
              child: Container(
                color: context.primaryColor.withAlpha(30),
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: context.primaryColorLight,
                ),
                padding: EdgeInsets.all(8),
              ),
            )),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.width * .5,
                child: FittedBox(
                  child: TodoListLogo(),
                  fit: BoxFit.fitHeight,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Form(
                  child: Column(
                    children: [
                      TodoListField(label: 'Email'),
                      SizedBox(
                        height: 10,
                      ),
                      TodoListField(
                        label: 'Senha',
                        obscure: true,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TodoListField(
                        label: 'Confirma Senha',
                        obscure: true,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('Login'),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
