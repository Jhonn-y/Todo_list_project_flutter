import 'package:todo_list_project/app/core/notifier/defaultNotifier.dart';
import 'package:todo_list_project/app/exception/auth_exceptions.dart';
import 'package:todo_list_project/app/services/user/userService.dart';

class LoginController extends DefaultNotifier{
  final UserService _userService;
  String? messager;

  LoginController({ required UserService userService}):_userService = userService;
  
  bool get hasInfo => messager != null;

  Future<void> login(String email,String password,) async {
    try {
      showLoadingAndResetState();
      messager != null;
      notifyListeners();
      final user = await _userService.login(email,password);
      if(user != null) {
        success();
      
  }
  else {
    setError('Email or password is incorrect');
  }
} on AuthExceptions catch (e) {
    setError(e.message);
}finally{
  hideLoading();
  notifyListeners();
}
  }

  Future<void> forgotPassword(String email) async {
    try {
  showLoadingAndResetState();
  messager != null;
  notifyListeners();
  await _userService.forgotPassword(email);
  messager = "Reset de senha enviado para o email!";
} on AuthExceptions catch (e) {
  setError(e.message);
}
catch (e) {
  setError("Erro ao resetar a senha ");
}
  finally{
    hideLoading();
    notifyListeners();
  }

}
Future<void> googleSignIn() async {
  try {
  showLoadingAndResetState();
  messager != null;
  notifyListeners();
  final user = await _userService.googleSingIn();
  if(user != null) {
    success();
  }else{
    _userService.logOut();
    setError('Não foi possível fazer login com o Google');
  }
  }on AuthExceptions catch(e){
    _userService.logOut();
    setError(e.message);
  }finally{
    hideLoading();
    notifyListeners();
  }
}

}