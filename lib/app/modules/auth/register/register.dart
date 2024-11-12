import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_project/app/core/notifier/defaultListener.dart';
import 'package:todo_list_project/app/core/ui/messages.dart';
import 'package:todo_list_project/app/core/validators/validators.dart';
import 'package:todo_list_project/app/core/ui/themeExtentions.dart';
import 'package:todo_list_project/app/core/widgets/todoListField.dart';
import 'package:todo_list_project/app/core/widgets/todoListLogo.dart';
import 'package:todo_list_project/app/modules/auth/controllers/registerController.dart';
import 'package:validatorless/validatorless.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confPasswordEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    final defaultlistener =
        DefaultListener(changeNotifier: context.read<RegisterController>());
    defaultlistener.listener(
      context: context,
      succesCallback: (notifier, listenerIntance) {
        listenerIntance.dispose();
        // Navigator.of(context).pop();
      },
      error: (notifier, listenerIntance) {
        Messages.of(context).showError('Erro');      },
    );

    // context.read<RegisterController>().addListener(() {
    //   var control = context.read<RegisterController>();
    //   var sucess = control.sucess;
    //   var error = control.error;
    //   if (sucess) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text('Registration successful'),
    //         backgroundColor: Colors.green[400],
    //       ),
    //     );
    //     Navigator.pop(context);
    //   } else if (error != null && error.isNotEmpty) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text(error),
    //         backgroundColor: Colors.red[400],
    //       ),
    //     );
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    _confPasswordEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
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
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: context.primaryColorLight,
                ),
              ),
            )),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * .5,
                child: const FittedBox(
                  fit: BoxFit.fitHeight,
                  child: TodoListLogo(),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TodoListField(
                        label: 'Email',
                        controller: _emailEC,
                        validator: Validatorless.multiple([
                          Validatorless.required('Email is required'),
                          Validatorless.email('Wrong email address')
                        ]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TodoListField(
                        label: 'Senha',
                        obscure: true,
                        controller: _passwordEC,
                        validator: Validatorless.multiple([
                          Validatorless.required('Password is required'),
                          Validatorless.min(
                              6, 'Password have a minimum of 6 characters'),
                        ]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TodoListField(
                        label: 'Confirma Senha',
                        obscure: true,
                        controller: _confPasswordEC,
                        validator: Validatorless.multiple([
                          Validatorless.required(
                              'Confirm password is required'),
                          Validators.compare(
                              _passwordEC, 'Passwords do not match'),
                        ]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {
                            final formValid =
                                _formKey.currentState?.validate() ?? false;
                            if (formValid) {
                              final email = _emailEC.text;
                              final password = _passwordEC.text;

                              context
                                  .read<RegisterController>()
                                  .registerUser(email, password);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text('Login'),
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
