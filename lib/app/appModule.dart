import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_project/app/appWidget.dart';
import '../app/core/auth/authProvider.dart';
import 'package:todo_list_project/app/core/database/connectionFactory.dart';
import 'package:todo_list_project/app/repo/users/userRepository.dart';
import 'package:todo_list_project/app/repo/users/userRepositoryImp.dart';
import 'package:todo_list_project/app/services/user/userService.dart';
import 'package:todo_list_project/app/services/user/userServiceImp.dart';

class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => FirebaseAuth.instance),
        Provider<UserRepository>(
          create: (context) => UserRepositoryImp(firebaseAuth: context.read(),),lazy: false,
        ),
        Provider(
          create: (_) => ConnectionFactory(),
          lazy: false,
        ),
        Provider<UserService>(
          create: (context) => UserServiceImp(userRepository: context.read<UserRepository>()),lazy: false,
        ),
        ChangeNotifierProvider(create: (context) => AuthProvide(firebaseAuth: context.read()
        , userService: context.read())..loadListeners(),
        lazy: false,)
      ],
      child: AppWidget(),
    );
  }
}
