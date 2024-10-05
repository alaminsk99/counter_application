import 'package:counter_application/auth/component/custom_text_field.dart';
import 'package:counter_application/auth/component/loading_button.dart';
import 'package:counter_application/auth/provider/forgot_password_provider.dart';
import 'package:counter_application/utility/constants.dart';
import 'package:counter_application/utility/extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
              padding:
              EdgeInsets.symmetric(horizontal: size.width>800? size.width*0.3: defaultPadding * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Screen Title
                  const Text(
                    "Recover Password",
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
                    color: secondaryColor,
                    child: Consumer<ForgotPasswordProvider>(
                      builder: (context, forgotPasswordProvider, child) {
                        return Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Form(
                            key: context
                                .forgotPasswordProvider.forgotPasswordFormKey,
                            child: Column(
                              children: [
                                // Email Text Field
                                CustomTextField(
                                  controller: forgotPasswordProvider.emailCtrl,
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

                                // Reset Password Button
                                LoadingButton(
                                  title: "Send Reset Link",
                                  isLoading: forgotPasswordProvider.isLoading,
                                  onPressed: () {
                                    if (context.forgotPasswordProvider
                                        .forgotPasswordFormKey.currentState!
                                        .validate()) {
                                      context.forgotPasswordProvider
                                          .forgotPasswordFormKey.currentState!
                                          .save();
                                      context.forgotPasswordProvider
                                          .recoveryPassword();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
