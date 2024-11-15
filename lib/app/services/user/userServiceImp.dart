import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_project/app/repo/users/userRepository.dart';
import 'package:todo_list_project/app/services/user/userService.dart';

class UserServiceImp implements UserService {
  final UserRepository _userRepository;
  UserServiceImp({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<User?> register(String email, String password) =>
      _userRepository.register(email, password);

  @override
  Future<User?> login(String email, String password) {
    return _userRepository.login(email, password);
  }

  @override
  Future<void> forgotPassword(String email) =>
      _userRepository.forgotPassword(email);

  @override
  Future<User?> googleSingIn() {
    return _userRepository.googleSingIn();
  }

  @override
  Future<void> logOut() => _userRepository.logOut();

  @override
  Future<void> updateDisplayName(String name) =>
      _userRepository.updateDisplayName(name);
}
