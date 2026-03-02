import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth;

  AuthService({required FirebaseAuth auth}) : _auth = auth;

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    UserCredential user = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
    return user;
  }

  Future<UserCredential> registerNewUser({
    required String email,
    required String password,
  }) async {
    UserCredential user = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return user;
  }
}

 
