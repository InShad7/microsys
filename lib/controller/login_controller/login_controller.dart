// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:microsys/main.dart';
import 'package:microsys/view/home/home_screen.dart';

import '../../view/utils/colors.dart';

class LoginController extends ChangeNotifier {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPassView = true;

  togglePassView() {
    isPassView = !isPassView;
    notifyListeners();
  }

  Future<void> loginWithFirebase() async {
    try {
      // Attempt to sign in the user
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Check if the user was successfully authenticated
      if (userCredential.user != null) {
        Fluttertoast.showToast(
          msg: 'Login successful!',
          backgroundColor: green,
        );
        log('Login successful: ${userCredential.user!.email}');
        Navigator.pushAndRemoveUntil(
          NavigationService.navigatorKey.currentState!.context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false,
        );
      } else {
        Fluttertoast.showToast(msg: 'Login failed. Please try again.');
      }
    } on FirebaseAuthException catch (e) {
      log('errorMsg: ${e.code}');
      // Handle specific Firebase authentication errors
      String errorMessage = loginErrorHandleFun(e);
      Fluttertoast.showToast(msg: errorMessage);
      log('Login error: $errorMessage');
    } catch (e) {
      // Catch any other errors
      Fluttertoast.showToast(msg: 'An unexpected error occurred');
      log('Unexpected error: $e');
    }
  }

  String loginErrorHandleFun(FirebaseAuthException e) {
    String errorMessage = 'Invalid User';
    if (e.code == 'invalid-email') {
      errorMessage = 'The email address is not valid';
    } else if (e.code == 'user-not-found') {
      errorMessage = 'No user found with this email';
    } else if (e.code == 'wrong-password') {
      errorMessage = 'Incorrect password';
    } else if (e.code == 'email-already-in-use') {
      errorMessage = 'The email address is already in use';
    } else if (e.code == 'weak-password') {
      errorMessage = 'The password is too weak';
    }
    return errorMessage;
  }
}
