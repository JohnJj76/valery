import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences? _prefs;
  Future cargarPreferencias() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Método para -- Registrar Usuario
  Future<User?> register(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //content: Text(e.message.toString()),
        content: Text('El usuario ya se encuentra registrado!'),
        backgroundColor: Colors.red,
      ));
    } catch (e) {
      print(e);
    }
  }

  // Método para -- Logearse en la app
  Future<User?> Login(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //content: Text(e.message.toString()),
        content: Text('Usuario ó clave incorrecta!'),
        backgroundColor: Colors.red,
      ));
    } catch (e) {
      print(e);
    }
  }

  // Google
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
        UserCredential userCredential =
            await firebaseAuth.signInWithCredential(credential);
        return userCredential.user;
      }
    } catch (e) {
      print(e);
    }
  }

  // Cerrar
  Future signOut() async {
    await GoogleSignIn().signOut();
    await firebaseAuth.signOut();
  }
}
