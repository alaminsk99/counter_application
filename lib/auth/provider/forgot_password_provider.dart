import 'package:counter_application/auth/component/snack_bar_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  bool isLoading = false;

  final GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();
  final TextEditingController emailCtrl = TextEditingController();
  final size = MediaQuery.of(Get.context!).size;
  // Handles the password recovery process
  Future<void> recoveryPassword() async {
    // Validates the form before proceeding

    try {
      _setLoading(true);
      final String email = emailCtrl.text.trim();
      // Send password reset email via Firebase
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      clearFields();
      SnackBarHelper.showSuccessSnackBar(
          'Password recovery email has been sent!');
      Get.offAllNamed('/wrapper');
    } on FirebaseAuthException catch (e) {
      // Specific FirebaseAuthException error handling
      switch (e.code) {
        case 'invalid-email':
          SnackBarHelper.showErrorSnackBar(
              'Invalid email format. Please check your email.');
          break;
        case 'user-not-found':
          SnackBarHelper.showErrorSnackBar('No user found with this email.');
          break;
        default:
          SnackBarHelper.showErrorSnackBar(
              'An error occurred. Please try again.');
      }
    } catch (e) {
      // Handles any other errors
      SnackBarHelper.showErrorSnackBar('Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Toggles the loading state
  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  // Clears the input fields
  void clearFields() {
    emailCtrl.clear();
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    super.dispose();
  }
}
