import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_project/app/core/auth/authProvider.dart';
import 'package:todo_list_project/app/core/ui/messages.dart';
import 'package:todo_list_project/app/core/ui/themeExtentions.dart';
import 'package:todo_list_project/app/services/tasks/tasksService.dart';
import 'package:todo_list_project/app/services/user/userService.dart';

class HomeDrawer extends StatefulWidget {

  HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  final nameVN = ValueNotifier<String>('');

  Future<void> removeTasksAndLogout(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text(
            'Deseja sair',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Deseja sair do Todo List e remover todas as suas tarefas registradas?',
            style: TextStyle(
              fontSize: 16,
              height: 1.2,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await context.read<TasksService>().removeAllTasks();

                if (!mounted) return;
                context.read<AuthProvide>().logout();

              },
              child: const Text(
                'SIM',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'NÃO',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.primaryColor.withAlpha(70),
            ),
            child: Row(
              children: [
                Selector<AuthProvide, String>(
                  builder: (_, value, __) {
                    return CircleAvatar(
                      backgroundImage: AssetImage(value),
                      radius: 30,
                    );
                  },
                  selector: (context, authProvider) {
                    return authProvider.user?.photoURL ??
                        'Assets/fotoperfil.png';
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Selector<AuthProvide, String>(
                      builder: (_, value, __) {
                        return Text(
                          value,
                          style: context.textTheme.titleSmall,
                        );
                      },
                      selector: (context, authProvider) {
                        return authProvider.user?.displayName ??
                            "Nome invalido";
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: Text('Alterar Nome'),
                    content: TextField(onChanged: (value) {
                      nameVN.value = value;
                    }),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Cancelar",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            final nameValue = nameVN.value;
                            if (nameValue.isEmpty) {
                              Messages.of(context)
                                  .showError("Nome Obrigatório");
                            } else {
                              Loader.show(context);
                              context
                                  .read<UserService>()
                                  .updateDisplayName(nameValue);
                              Loader.hide();
                              Navigator.of(context).pop();
                            }
                          },
                          child: Text("Alterar"))
                    ],
                  );
                },
              );
            },
            title: Text('Alterar nome'),
          ),
          ListTile(
            onTap: () async => await removeTasksAndLogout(context),
            title: Text('Sair'),
          ),
        ],
      ),
    );
  }
}
