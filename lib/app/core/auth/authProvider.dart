import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:todo_list_project/app/core/navigator/todoListNavigator.dart';
import 'package:todo_list_project/app/services/user/userService.dart';

class Authprovider extends ChangeNotifier{
  final FirebaseAuth _firebaseAuth;
  final UserService _userService;

  Authprovider({required FirebaseAuth firebaseAuth,required UserService userService})
    : _firebaseAuth = firebaseAuth, _userService = userService;

  Future<void> logout() => _userService.logOut();
  User? get user => _firebaseAuth.currentUser;

  void loadListeners(){
    _firebaseAuth.userChanges().listen((_) => notifyListeners());
    _firebaseAuth.idTokenChanges().listen((user){
        if(user != null){
          TodoListNavigator.to.pushNamedAndRemoveUntil('/home', (route) => false);
        }else{
          TodoListNavigator.to.pushNamedAndRemoveUntil('/login', (route) => false);
        }
    });
  }


}