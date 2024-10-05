import 'package:counter_application/auth/component/custom_text_field.dart';
import 'package:counter_application/auth/component/loading_button.dart';
import 'package:counter_application/auth/provider/sign_up_provider.dart';
import 'package:counter_application/utility/constants.dart';
import 'package:counter_application/utility/extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [bgColor.withOpacity(0.5), bgColor],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: size.width>800? size.width*0.3: defaultPadding * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    "Welcome to Counter Application",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width < 600 ? 30 : 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Form Card
                  Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: secondaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Consumer<SignUpProvider>(
                        builder: (context, value, child) {
                          return Form(
                            key: context.signUpProvider.signUpFormKey,
                            child: Column(
                              children: [
                                // User Name
                                CustomTextField(
                                  controller: context.signUpProvider.userNameCtrl,
                                  labelText: "User Name",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'User name should not be empty';
                                    }
                                    return null;
                                  },
                                  onSave: (value) {},
                                ),
                                const SizedBox(height: defaultPadding),

                                // Email
                                CustomTextField(
                                  controller: context.signUpProvider.emailCtrl,
                                  labelText: "Email",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a valid email address';
                                    }
                                    return null;
                                  },
                                  onSave: (value) {},
                                ),
                                const SizedBox(height: defaultPadding),

                                // Password
                                CustomTextField(
                                  controller: context.signUpProvider.passwordCtrl,
                                  labelText: "Password",
                                  validator: (value) {
                                    if (value == null || value.length < 6 || value.length >= 12) {
                                      return 'Password must be between 6-12 characters';
                                    }
                                    return null;
                                  },
                                  onSave: (value) {},
                                ),
                                const SizedBox(height: defaultPadding),

                                // Sign-Up Button
                                LoadingButton(
                                  title: "Sign Up",
                                  isLoading: value.isLoading,
                                  onPressed: () {
                                    if(context.signUpProvider.signUpFormKey.currentState!.validate()){
                                      context.signUpProvider.signUpFormKey.currentState!.save();
                                      context.signUpProvider.signUp();
                                    }

                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
