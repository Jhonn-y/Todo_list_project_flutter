import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_list_project/app/exception/auth_exceptions.dart';
import 'package:todo_list_project/app/repo/users/userRepository.dart';

class UserRepositoryImp implements UserRepository {
  
  final FirebaseAuth _firebase;
  
  UserRepositoryImp({required FirebaseAuth firebaseAuth}) : _firebase = firebaseAuth;
  
  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredential = await _firebase.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
      
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {

        //LoginTypes está retornando NULL e não sei o motivo
        // loginTypes.contains('password') não funciona por conta disso.

        final loginTypes = await  _firebase.fetchSignInMethodsForEmail(email);
        if (loginTypes.firstOrNull == null || loginTypes.firstOrNull == 'password') {
          throw AuthExceptions(message: "Email já utilizado.");
        }else{
          throw AuthExceptions(message: "Email já cadastrado pelo Google.");
        }
      }else {
        (
        throw AuthExceptions(message: e.message ?? "Erro ao cadastrar usuario.")
      );
      }
    }

  }
  
  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredential = await _firebase.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
      
    } on FirebaseAuthException catch (e) {
      if(e.code == 'invalid-credential'){
        throw AuthExceptions(message: "Email ou senha invalidos!");
      }
      throw AuthExceptions(message: e.message ?? "Erro ao fazer login.");

    } on PlatformException catch (e){

      throw AuthExceptions(message: e.message ?? "Erro ao fazer login.");

    }
  }
  
  @override
  Future<void> forgotPassword(String email) async {
    try {
  final method = await _firebase.fetchSignInMethodsForEmail(email);
  
  if(method.contains('password') ){
    await _firebase.sendPasswordResetEmail(email: email);
  }else if(method.contains('google')){
    throw AuthExceptions(message: 'Email cadastrado pelo Google');
  }else{
    throw AuthExceptions(message: 'Email não cadastrado.');
  }
} on PlatformException {
  throw AuthExceptions(message: "Erro ao recuperar senha.");
}
  }
  
  @override
  Future<User?> googleSingIn() async {
    List<String>? loginMethods;
    try {
  final googleSingIn = GoogleSignIn();
  final googleUser = await googleSingIn.signIn();
  if(googleUser != null) {
    loginMethods = await _firebase.fetchSignInMethodsForEmail(googleUser.email);
  
  if(loginMethods == 'password'){
    throw AuthExceptions(message: "Voce não cadastrou esse email pelo Google");
  }else{
    final googleAuth = await googleUser.authentication;
    final firebaseProvider = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken, idToken: googleAuth.idToken,
    );
    var userCredential = await _firebase.signInWithCredential(firebaseProvider);
    return userCredential.user;
  }
    }
} on FirebaseAuthException catch (e) {
  if(e.code == 'account-exists-with-different-credential') {
    throw AuthExceptions(message: '''
    Uma conta com esse email já existe, feito atráves dos provedores:
    ${loginMethods?.join(',')}
    ''');

  }else{
    throw AuthExceptions(message: "Erro ao fazer login com Google.");
  }
}
    return null;
}

  @override
  Future<void> logOut() async {
    await GoogleSignIn().signOut();
    _firebase.signOut();
  }
  
  @override
  Future<void> updateDisplayName(String name) async {
    final user = _firebase.currentUser;
    if(user != null){
      await user.updateDisplayName(name);
      user.reload();
    }
  }
}