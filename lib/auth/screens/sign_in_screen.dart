import 'package:counter_application/auth/component/custom_text_field.dart';
import 'package:counter_application/auth/component/loading_button.dart';
import 'package:counter_application/auth/provider/sign_in_provider.dart';
import 'package:counter_application/auth/screens/forgot_password_screen.dart';
import 'package:counter_application/auth/screens/sign_up_screen.dart';
import 'package:counter_application/utility/constants.dart';
import 'package:counter_application/utility/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});


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
             padding:  EdgeInsets.symmetric(horizontal: size.width>800? size.width*0.3: defaultPadding * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title
                  const Text(
                    "Welcome Back!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
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
                    color: secondaryColor, // Card background color
                    child: Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Consumer<SignInProvider>(
                        builder: (context, value, child) {
                          return Form(
                            key: context.signInProvider.signInformKey,
                            child: Column(
                              children: [
                                // Email Text Field
                                CustomTextField(
                                  controller: context.signInProvider.emailCtrl,
                                  labelText: "Email",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a valid email address';
                                    }
                                    return null;
                                  },
                                  inputType: TextInputType.emailAddress,
                                  onSave: (value) {},
                                ),
                                const SizedBox(height: defaultPadding),

                                // Password Text Field
                                CustomTextField(
                                  controller: context.signInProvider.passwordCtrl,
                                  labelText: "Password",
                                  validator: (value) {
                                    if (value == null || value.length < 6 || value.length > 12) {
                                      return 'Password must be 6-12 characters long';
                                    }
                                    return null;
                                  },
                                  inputType: TextInputType.visiblePassword,
                                  onSave: (val) {},
                                ),
                                const SizedBox(height: defaultPadding / 2),

                                // Forgot Password Button
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                     Get.to(const ForgotPasswordScreen());
                                    },
                                    child: const Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: defaultPadding),

                                // Login Button
                                LoadingButton(
                                  title: "Login",
                                  isLoading: context.signInProvider.isLoading,
                                  onPressed: () {
                                    if(context.signInProvider.signInformKey.currentState!.validate()){
                                      context.signInProvider.signInformKey.currentState!.save();
                                      context.signInProvider.signIn();
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
                  const SizedBox(height: 15),

                  // Sign Up Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.white70),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(const SignupScreen());
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
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
