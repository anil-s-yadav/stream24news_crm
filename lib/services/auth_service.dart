import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Hardcoded authorized email
  static const String authorizedEmail = 'paytmking15@gmail.com';

  bool isUserLoggedIn() {
    return _auth.currentUser != null;
  }

  User? getUser() {
    return _auth.currentUser;
  }

  // Login with email & password
  Future<User?> loginUserWithEmailAndPassword(
      String email, String password) async {
    final cleanedEmail = email.trim().toLowerCase();

    try {
      // final methods = getSignInMethods(cleanedEmail);
      final cred = await _auth.signInWithEmailAndPassword(
        email: cleanedEmail,
        password: password,
      );
      return cred.user;
    } on FirebaseAuthException catch (e) {
      log("FirebaseAuthException (login): ${e.code} - ${e.message}");
      throw FirebaseAuthException(
        code: e.code,
        message: e.message,
      );
    } catch (e) {
      log("General Exception (login): $e");
      throw Exception(e.toString());
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("Error signing out: $e");
      throw Exception("Error signing out. Please try again.");
    }
  }
}


/*
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Hardcoded authorized email
  static const String authorizedEmail = 'paytmking15@gmail.com';

  // Sign in with email and password
  Future<UserCredential> signInWithEmailPassword(
      String email, String password) async {
    if (email.toLowerCase() != authorizedEmail.toLowerCase()) {
      throw FirebaseAuthException(
        code: 'unauthorized',
        message: 'This email is not authorized to access the application.',
      );
    }
    return await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get current user

  // Auth state changes stream
}
*/