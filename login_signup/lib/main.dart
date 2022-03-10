import 'package:login_signup/dashboard.dart';
import 'login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'home_feed.dart';
import 'registration_screen.dart';
import 'splash_screen.dart';
import 'onboard_screen.dart';
import 'profile2.dart';
import 'rating.dart';
import 'timeline.dart';
import 'admin.dart';
import 'all_users.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'login',
      routes: {
        'splash_screen': (context) => SplashScreen(title: 'Splash'),
        'login': (context) =>  LoginScreen(),
        'profile': (context) => ProfilePage(), //todo:profile2
        'home_feed': (context) => HomeFeed() ,
        'welcome_screen': (context) => OnboardingScreen(),
        'registration_screen': (context) => RegistrationScreen(),
        'admin':(context) => AdminLogin(),
        'dashboard': (context) => Dashboard(),
        'all_users': (context) => AllUsers(),
        // 'ratings': (context) = 
        'rate_driver' :(context) =>RatingPage() },
    );
    //   title: 'Email And Password Login',
    //   theme: ThemeData(
    //     primarySwatch: Colors.red,
    //   ),
    //   debugShowCheckedModeBanner: false,
    //   home: LoginScreen(),
    // );
  }
}