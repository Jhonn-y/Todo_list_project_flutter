import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_project/app/core/auth/authProvider.dart';
import 'package:todo_list_project/app/core/ui/messages.dart';
import 'package:todo_list_project/app/core/ui/themeExtentions.dart';
import 'package:todo_list_project/app/services/user/userService.dart';

class HomeDrawer extends StatelessWidget {

  final nameVN = ValueNotifier<String>('');

  HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.primaryColor.withAlpha(70),
            ),
            child: Row(
              children: [
                Selector<Authprovider, String>(
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
                    child: Selector<Authprovider, String>(
                      builder: (_, value, __) {
                        return Text(
                          value,
                          style: context.textTheme.titleSmall,
                        );
                      },
                      selector: (context, authProvider) {
                        return authProvider.user?.displayName ?? "Nome invalido";
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap:(){showDialog(context: context,builder: (_) {
              return AlertDialog(
                title: Text('Alterar Nome'),
                content: TextField(
                  onChanged: (value) {
                    nameVN.value = value;
                  }),
                  actions: [
                    TextButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, child: Text("Cancelar",
                    style: TextStyle(color: Colors.red),),),

                    TextButton(onPressed: (){
                      final nameValue = nameVN.value;
                      if(nameValue.isEmpty){
                        Messages.of(context).showError("Nome Obrigatório");
                      }else{
                        Loader.show(context);
                        context.read<UserService>().updateDisplayName(nameValue);
                        Loader.hide();
                        Navigator.of(context).pop();
                      }
                    }, child: Text("Alterar"))
                  ],
              );
            },);},
            title: Text('Alterar nome'),
          ),
          ListTile(onTap: () => context.read<Authprovider>().logout(),
          title: Text('Sair'),),
        ],
      ),
    ));
  }
}
