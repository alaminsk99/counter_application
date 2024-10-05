import 'package:counter_application/auth/provider/forgot_password_provider.dart';
import 'package:counter_application/auth/provider/sign_in_provider.dart';
import 'package:counter_application/auth/provider/sign_up_provider.dart';

import 'package:counter_application/main/screens/provider/home_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension Providers on BuildContext {
  SignInProvider get signInProvider => Provider.of<SignInProvider>(this, listen: false);
  SignUpProvider get signUpProvider => Provider.of<SignUpProvider>(this, listen: false);
  ForgotPasswordProvider get forgotPasswordProvider => Provider.of<ForgotPasswordProvider>(this, listen: false);
  HomePageProvider get homePageProvider => Provider.of<HomePageProvider>(this, listen: false);

}