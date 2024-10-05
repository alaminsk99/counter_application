
import 'package:counter_application/auth/screens/sign_in_screen.dart';
import 'package:counter_application/main/screens/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return  HomeScreen();
        }else{
          return  SignInScreen();
        }
      },
    );
  }
}



