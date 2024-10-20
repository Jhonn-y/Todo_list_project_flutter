import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_project/app/core/notifier/defaultListener.dart';
import 'package:todo_list_project/app/core/ui/messages.dart';
import 'package:todo_list_project/app/core/widgets/todoListField.dart';
import 'package:todo_list_project/app/core/widgets/todoListLogo.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:todo_list_project/app/modules/auth/controllers/loginController.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    final defaultlistener =
        DefaultListener(changeNotifier: context.read<LoginController>());
    defaultlistener.listener(
      context: context,
      succesCallback: (notifier, listenerIntance) {
        listenerIntance.dispose();
        Navigator.of(context).pop();
      },
      everCallback: (notifier, listenerIntance) {
        if(notifier is LoginController) {
          if(notifier.hasInfo){
            Messages.of(context).showInfo(notifier.messager!);
          }
        }

      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constrains) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constrains.maxHeight,
              minWidth: constrains.maxWidth,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const TodoListLogo(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 40,
                      horizontal: 25,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: TodoListField(
                            label: 'Email',
                            controller: _emailEC,
                            node: _focus,
                            validator: Validatorless.multiple([
                              Validatorless.required('Email é obrigatório'),
                              Validatorless.email('Email inválido'),
                            ]),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TodoListField(
                          label: 'Senha',
                          obscure: true,
                          controller: _passwordEC,
                          validator: Validatorless.multiple([
                              Validatorless.required('Senha é obrigatório'),
                              Validatorless.min(6,'Senha com minimo de 6 caracteres'),
                            ]),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                if(_emailEC.text.isNotEmpty){
                                  context.read<LoginController>().forgotPassword(_emailEC.text);
                                }else{
                                  _focus.requestFocus();
                                  Messages.of(context).showError("Digite um email para recuperar a senha");
                                }
                              },
                              child: const Text('Forgot your password?'),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                final formValidate = _formKey.currentState?.validate() ?? false;
                                if(formValidate){
                                  final email = _emailEC.text;
                                  final password = _passwordEC.text;

                                  context.read<LoginController>().login(email,password);
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
                          ],
                        ),
                      ]),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 109, 110, 110),
                        border: Border(
                          top: BorderSide(
                            color: Colors.black.withAlpha(50),
                            width: 2,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      SignInButton(
                        Buttons.google,
                        onPressed: () {
                          context.read<LoginController>().googleSignIn();
                        },
                        text: 'Login with Google',
                        padding: const EdgeInsets.all(10),
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Dont have an anccont?'),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/register');
                            },
                            child: const Text("Sing In."),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
