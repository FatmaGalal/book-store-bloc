import 'package:firebase_auth/firebase_auth.dart';

String firebaseAuthError(FirebaseAuthException error) {


  return error.message.toString();
}