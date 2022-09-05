import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthService {
  Future<UserCredential> signIn(
      {required String email, required String password});
  Future<void> signOut();
}

class AuthService extends IAuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<void> signOut() {
    return auth.signOut();
  }

  @override
  Future<UserCredential> signIn(
      {required String email, required String password}) {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<UserCredential> createUser(
      {required String email, required String password}) {
    return auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }
}
