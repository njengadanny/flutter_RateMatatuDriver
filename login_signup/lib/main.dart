import 'package:login_signup/admin/all_drivers.dart';
import 'package:login_signup/admin/dashboard.dart';
import 'package:login_signup/driver/driver_homefeed.dart';
import 'package:login_signup/driver/driver_login.dart';
import 'package:login_signup/driver/driver_profile.dart';
import 'package:login_signup/driver/driver_registration.dart';
import 'package:login_signup/admin/top_drivers.dart';
import 'package:login_signup/driver/driver_timeline.dart';
import 'package:login_signup/update_profile.dart';
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
import 'admin/admin.dart';
import 'admin/all_users.dart';
import 'rate_history.dart';
import 'driver/driver_reputation.dart';
import 'admin/report.dart';

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
      initialRoute: 'splash_screen',
      routes: {
        'splash_screen': (context) => SplashScreen(title: 'Splash'),
        'registration_screen': (context) => RegistrationScreen(),
        'login': (context) =>  LoginScreen(),
        'profile': (context) => ProfilePage(), //todo:profile2
        'homefeed': (context) => HomeFeed() ,
        'welcome_screen': (context) => OnboardingScreen(),        
        'admin':(context) => AdminLogin(),
        'dashboard': (context) => Dashboard(),
        'all_users': (context) => AllUsers(),
        'all_drivers': (context) => AllDrivers(),
        'top_drivers': (context) => TopDrivers(),
        'update' : (context) => UpdateProfile(),
        'driver_login': (context) => DriverLogin(),
        'driver_registration': (context) => DriverRegistration(),
        'driver_reputation': (context) => DriverReputation(),
        'driver_profile':(context) => DriverProfilePage(),
        'driver_homefeed':(context) => DriverHomeFeed(),
        'driver_timeline':(context) => DriverTimeline(),
        'rate_driver' :(context) =>RatingPage(),
        'rate_history':(context) => RateHistory(),
        'report' :(context) => Report() },
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