
import 'package:todo_list_project/app/core/notifier/defaultNotifier.dart';
import 'package:todo_list_project/app/exception/auth_exceptions.dart';
import 'package:todo_list_project/app/services/user/userService.dart';
class RegisterController extends DefaultNotifier{
  final UserService _userService;

  RegisterController({required UserService userService}): _userService = userService;

  Future<void> registerUser(String email,String password,) async {
    try {
  showLoadingAndResetState();
  notifyListeners();
  final userRegistered = await _userService.register(email,password);
  if(userRegistered != null) {
    success();
  
  }
  else {
    setError('Failed to register user');
  }
} on AuthExceptions catch (e) {
  setError(e.message);
}finally{
  hideLoading();
  notifyListeners();
}
  }
  
}