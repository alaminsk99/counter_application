import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counter_application/auth/component/snack_bar_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpProvider extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final size = MediaQuery.of(Get.context!).size;
  final TextEditingController userNameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  bool isLoading = false;

  // Sign-up function
  Future<void> signUp() async {
    try {
      final String email = emailCtrl.text.trim();
      final String password = passwordCtrl.text.trim();
      final String name = userNameCtrl.text.trim();
      _setLoading(true); // Show loading indicator

      // Firebase Authentication sign-up
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // Save user data to Firebase DataBase
        await firestore.collection('users').doc(userCredential.user!.uid).set(
          {
            'name': name,
            'email': email,
          },
        );
        clearFields();
        // Show success message
        SnackBarHelper.showSuccessSnackBar("Sign Up Successful!");

        // Navigate to Wrapper screen
        Get.offAllNamed('/wrapper');
      } else {
        SnackBarHelper.showErrorSnackBar("An error occurred during sign-up.");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        SnackBarHelper.showErrorSnackBar(
            "The email address is already in use.");
      } else if (e.code == 'weak-password') {
        SnackBarHelper.showErrorSnackBar("The password provided is too weak.");
      } else if (e.code == 'invalid-email') {
        SnackBarHelper.showErrorSnackBar("The email address is invalid.");
      } else {
        SnackBarHelper.showErrorSnackBar(
            "An unexpected error occurred. Please try again.");
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar(e.toString());
    } finally {
      _setLoading(false); // Hide loading indicator
    }
  }

  // Set loading state
  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners(); // Notify listeners about the loading state change
  }

  // Clear text fields after signup
  void clearFields() {
    emailCtrl.clear();
    passwordCtrl.clear();
    userNameCtrl.clear();
  }

  // Dispose of the controllers to prevent memory leaks
  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    userNameCtrl.dispose();
    super.dispose();
  }
}
