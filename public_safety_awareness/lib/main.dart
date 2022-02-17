// @dart=2.9
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:public_safety_awareness/profile_page.dart';
import 'package:public_safety_awareness/splash_screen.dart';
import 'welcome_screen.dart';
import 'home_screen.dart';
import 'signup_screen.dart';
import 'login_screen.dart';
import 'splash_screen.dart';
import 'signup.dart';
import 'login_page.dart';
import 'profile_page.dart';
import 'profile2.dart';
import 'showUser.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'splash_screen',
      routes: {
        'splash_screen': (context) => SplashScreen(title: 'Splash'),
        'login': (context) =>  LoginPage(),
        'profile': (context) => GetCurrentUser(), //todo:profile2
        'home_feed': (context) => HomeScreen() ,
        'welcome_screen': (context) => OnboardingScreen(),
        'registration_screen': (context) => RegistrationScreen() },
    );
  }
}
