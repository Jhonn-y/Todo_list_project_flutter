import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_project/app/core/ui/themeExtentions.dart';

import '../auth/authProvider.dart';

class HomeHeader extends StatelessWidget {

  const HomeHeader({ super.key });

  @override
  Widget build(BuildContext context) {
      return Padding(padding: EdgeInsets.symmetric(vertical: 20),
      child: Selector<AuthProvide,String>(builder: (_, value, __) {
        return Text('E ai, $value!',
        style: context.textTheme.headlineMedium ?.copyWith(fontWeight: FontWeight.bold),);
      }, selector: (context, authProvider) => authProvider.user?.displayName ?? "Não informado",),);
  }
}