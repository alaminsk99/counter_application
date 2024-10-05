import 'package:counter_application/auth/component/snack_bar_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInProvider extends ChangeNotifier {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final size = MediaQuery.of(Get.context!).size;
  final GlobalKey<FormState> signInformKey = GlobalKey<FormState>();

  bool isLoading = false;

  // Sign-in function
  Future<void> signIn() async {
    try {
      _setLoading(true);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailCtrl.text.trim(),
        password: passwordCtrl.text.trim(),
      );
      // Show success message
      SnackBarHelper.showSuccessSnackBar("Login Successfully");
      clearFields();
      // Navigate to Wrapper screen
      Get.offAllNamed('/wrapper');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        SnackBarHelper.showErrorSnackBar("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        SnackBarHelper.showErrorSnackBar("Wrong password provided.");
      } else if (e.code == 'invalid-email') {
        SnackBarHelper.showErrorSnackBar("The email address is invalid.");
      } else {
        SnackBarHelper.showErrorSnackBar(
            "An unexpected error occurred. Please try again.");
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar("Error: $e");
    } finally {
      _setLoading(false);
    }
  }

  // Set loading state
  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  // Clear text fields after sign-in
  void clearFields() {
    emailCtrl.clear();
    passwordCtrl.clear();
  }

  // Dispose of the controllers
  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }
}
