
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:public_safety_awareness/home_screen.dart';
import 'package:public_safety_awareness/signup_screen.dart';
import 'theme_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'forgot_password_page.dart';
import 'profile_page.dart';
import 'registration_page.dart';
import 'header_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';


class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}): super(key:key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  double _headerHeight = 250;
  Key _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.login_rounded), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),// This will be the login form
                  child: Column(
                    children: [
                      const Text(
                        'Hello',
                        style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Sign in into your account',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 10.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                child: TextField(
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (value) {
                                    email = value;
                                    //Do something with the user input.
                                  },
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Email', 'Enter your email'),
                                ),
                                decoration: ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              const SizedBox(height: 20.0),
                              Container(
                                child: TextField(
                                  obscureText: true,
                                  onChanged: (value) {
                                    password = value;
                                    //Do something with the user input.
                                  },
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Password', 'Enter your password'),
                                ),
                                decoration: ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              const SizedBox(height: 10.0),
                              Container(
                                margin: const EdgeInsets.fromLTRB(10,0,10,20),
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push( context, MaterialPageRoute( builder: (context) => const ForgotPasswordPage()), );
                                  },
                                  child: const Text( "Forgot your password?", style: TextStyle( color: Colors.grey, ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                    child: Text('Log In'.toUpperCase(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                  ),
                                  onPressed: () async {
                                    try {
                                      final user = await _auth.signInWithEmailAndPassword(
                                          email: email, password: password);
                                      if (user != null) {
                                        Navigator.pushNamed(context, 'home_feed');
                                      }
                                    } catch (e) {
                                      print(e);
                                      Fluttertoast.showToast(
                                          msg: e.toString(),
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.blue,
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                    }
                                    //After successful login we will redirect to profile page. Let's create profile page now
                                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10,20,10,20),
                                //child: Text('Don\'t have an account? Create'),
                                child: Text.rich(
                                    TextSpan(
                                        children: [
                                          const TextSpan(text: "Don't have an account? "),
                                          TextSpan(
                                            text: 'Create',
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen()));
                                              },
                                            style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),
                                          ),
                                        ]
                                    )
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  )
              ),
            ),
          ],
        ),
      ),
    );

  }
}