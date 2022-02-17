import 'home_feed.dart';
import 'registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'designs/theme_helper.dart';
import 'package:flutter/gestures.dart';
import 'designs/header_widget.dart';
import 'forgot_password_page.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // form key
  final _formKey = GlobalKey<FormState>();
  double _headerHeight = 250;


  // editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // firebase
  final _auth = FirebaseAuth.instance;
  
  // string for displaying the error Message
  String? errorMessage;

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
                                child: TextFormField(
                                  autofocus: false,
                                  controller: emailController,
                                  decoration: ThemeHelper().textInputDecoration('Email', 'Enter your email'),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return ("Please Enter Your Email");
                                    }
                                    // reg expression for email validation
                                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                        .hasMatch(value)) {
                                      return ("Please Enter a valid email");
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    emailController.text = value!;
                                  },
                                ),
                                decoration: ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              const SizedBox(height: 20.0),
                              Container(
                                child: TextFormField(
                                  autofocus: false,
                                  controller: passwordController,
                                  decoration: ThemeHelper().textInputDecoration('Password*', 'Enter your password'),
                                  obscureText: true,
                                  validator: (value) {
                                    RegExp regex = new RegExp(r'^.{6,}$');
                                    if (value!.isEmpty) {
                                      return ("Password is required for login");
                                    }
                                    if (!regex.hasMatch(value)) {
                                      return ("Enter Valid Password(Min. 6 Character)");
                                    }
                                  },
                                  onSaved: (value) {
                                    passwordController.text = value!;
                                  },
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
                                    signIn(emailController.text, passwordController.text);
                                    // try {
                                    //   final user = await _auth.signInWithEmailAndPassword(
                                    //       email: email, password: password);
                                    //   if (user != null) {
                                    //     Navigator.pushNamed(context, 'home_feed');
                                    //   }
                                    // } catch (e) {
                                    //   print(e);
                                    //   Fluttertoast.showToast(
                                    //       msg: e.toString(),
                                    //       toastLength: Toast.LENGTH_SHORT,
                                    //       gravity: ToastGravity.CENTER,
                                    //       timeInSecForIosWeb: 1,
                                    //       backgroundColor: Colors.blue,
                                    //       textColor: Colors.white,
                                    //       fontSize: 16.0
                                    //   );
                                    // }
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
    // email field
    // final emailField = TextFormField(
    //     autofocus: false,
    //     controller: emailController,
    //     keyboardType: TextInputType.emailAddress,
    //     validator: (value) {
    //       if (value!.isEmpty) {
    //         return ("Please Enter Your Email");
    //       }
    //       // reg expression for email validation
    //       if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
    //           .hasMatch(value)) {
    //         return ("Please Enter a valid email");
    //       }
    //       return null;
    //     },
    //     onSaved: (value) {
    //       emailController.text = value!;
    //     },
    //     textInputAction: TextInputAction.next,
    //     decoration: InputDecoration(
    //       prefixIcon: Icon(Icons.mail),
    //       contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
    //       hintText: "Email",
    //       border: OutlineInputBorder(
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //     ));

    // //password field
    // final passwordField = TextFormField(
    //     autofocus: false,
    //     controller: passwordController,
    //     obscureText: true,
    //     validator: (value) {
    //       RegExp regex = new RegExp(r'^.{6,}$');
    //       if (value!.isEmpty) {
    //         return ("Password is required for login");
    //       }
    //       if (!regex.hasMatch(value)) {
    //         return ("Enter Valid Password(Min. 6 Character)");
    //       }
    //     },
    //     onSaved: (value) {
    //       passwordController.text = value!;
    //     },
    //     textInputAction: TextInputAction.done,
    //     decoration: InputDecoration(
    //       prefixIcon: Icon(Icons.vpn_key),
    //       contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
    //       hintText: "Password",
    //       border: OutlineInputBorder(
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //     ));

    // final loginButton = Material(
    //   elevation: 5,
    //   borderRadius: BorderRadius.circular(30),
    //   color: Colors.redAccent,
    //   child: MaterialButton(
    //       padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
    //       minWidth: MediaQuery.of(context).size.width,
    //       onPressed: () {
    //         signIn(emailController.text, passwordController.text);
    //       },
    //       child: Text(
    //         "Login",
    //         textAlign: TextAlign.center,
    //         style: TextStyle(
    //             fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
    //       )),
    // );

    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   body: Center(
    //     child: SingleChildScrollView(
    //       child: Container(
    //         color: Colors.white,
    //         child: Padding(
    //           padding: const EdgeInsets.all(36.0),
    //           child: Form(
    //             key: _formKey,
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: <Widget>[
    //                 SizedBox(
    //                     height: 200,
    //                     child: Image.asset(
    //                       "assets/images/logo.png",
    //                       fit: BoxFit.contain,
    //                     )),
    //                 SizedBox(height: 45),
    //                 emailField,
    //                 SizedBox(height: 25),
    //                 passwordField,
    //                 SizedBox(height: 35),
    //                 loginButton,
    //                 SizedBox(height: 15),
    //                 Row(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: <Widget>[
    //                       Text("Don't have an account? "),
    //                       GestureDetector(
    //                         onTap: () {
    //                           Navigator.push(
    //                               context,
    //                               MaterialPageRoute(
    //                                   builder: (context) =>
    //                                       RegistrationScreen()));
    //                         },
    //                         child: Text(
    //                           "SignUp",
    //                           style: TextStyle(
    //                               color: Colors.redAccent,
    //                               fontWeight: FontWeight.bold,
    //                               fontSize: 15),
    //                         ),
    //                       )
    //                     ])
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  // login function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomeFeed())),
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
}