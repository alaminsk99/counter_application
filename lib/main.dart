import 'package:counter_application/auth/provider/forgot_password_provider.dart';
import 'package:counter_application/auth/provider/sign_in_provider.dart';
import 'package:counter_application/auth/provider/sign_up_provider.dart';
import 'package:counter_application/main/screens/provider/home_page_provider.dart';
import 'package:counter_application/main/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/app_page.dart';
import 'utility/constants.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignInProvider()),
        ChangeNotifierProvider(create: (context) => SignUpProvider()),
        ChangeNotifierProvider(create: (context) => ForgotPasswordProvider()),
        ChangeNotifierProvider(create: (context) => HomePageProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Counter App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        canvasColor: secondaryColor,
      ),
      initialRoute: AppPages.HOME,
      unknownRoute: GetPage(name: '/notFound', page: () => Wrapper()),
      defaultTransition: Transition.cupertino,
      getPages: AppPages.routes,
    );
  }
}
