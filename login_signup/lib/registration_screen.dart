import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:login_signup/login_screen.dart';
import 'models/user_data.dart';
import 'home_feed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'designs/theme_helper.dart';
import 'designs/header_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  // late String lname;
  // late String fname;
  // late String email;
  // late String password;
  bool checkedValue = false;
  bool checkboxValue = false;


  
  // string for displaying the error Message
  String? errorMessage;


  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final firstNameEditingController = TextEditingController();
  final secondNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 150,
              child: const HeaderWidget(
                  150, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border:
                                      Border.all(width: 5, color: Colors.white),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 20,
                                      offset: Offset(5, 5),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey.shade300,
                                  size: 80.0,
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(80, 80, 0, 0),
                                child: Icon(
                                  Icons.add_circle,
                                  color: Colors.grey.shade700,
                                  size: 25.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: TextFormField(
                            autofocus: false,
                            controller: firstNameEditingController,
                            decoration: ThemeHelper().textInputDecoration('First Name', 'Enter your first name'),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              RegExp regex = RegExp(r'^.{3,}$');
                              if (value!.isEmpty) {
                                return ("First Name cannot be Empty");
                              }
                              if (!regex.hasMatch(value)) {
                                return ("Enter Valid name(Min. 3 Character)");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              firstNameEditingController.text = value!;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: TextFormField(
                            autofocus: false,
                            controller: secondNameEditingController,
                            decoration: ThemeHelper().textInputDecoration('Last Name', 'Enter your last name'),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Second Name cannot be Empty");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              secondNameEditingController.text = value!;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            autofocus: false,
                            controller: emailEditingController,
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
                              firstNameEditingController.text = value!;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            autofocus: false,
                            controller: passwordEditingController,
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
                              firstNameEditingController.text = value!;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 10.0),
                        FormField<bool>(
                          builder: (state) {
                            return Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Checkbox(
                                        value: checkboxValue,
                                        onChanged: (value) {
                                          setState(() {
                                            checkboxValue = value!;
                                            state.didChange(value);
                                          });
                                        }),
                                    const Text(
                                      "I accept all terms and conditions.",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.errorText ?? '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Theme.of(context).errorColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                          validator: (value) {
                            if (!checkboxValue) {
                              return 'You need to accept terms and conditions';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 5.0),
                        Container(
                          decoration:
                              ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Register".toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () async {
                              signUp(emailEditingController.text, passwordEditingController.text);
                              // final newUser = <String, dynamic>{
                              //   'fname': fname,
                              //   'lname': lname,
                              //   'email': email,
                              //   'time': DateTime.now().millisecondsSinceEpoch
                              // };
                              // database
                              // .child('users')
                              // .push()
                              // .set(newUser)
                              // .then((_) => print('new user added'))
                              // .catchError(
                              //   (error) => print('this is the error $error')
                              // );
                              // if (_formKey.currentState!.validate()) {
                              //   try {
                              //     final newUser = await _auth
                              //         .createUserWithEmailAndPassword(
                              //             email: email, password: password);
                              //     if (newUser != null) {
                              //       Navigator.pushNamed(context, 'login');
                              //     }
                              //   } catch (e) {
                              //     print(e);
                              //     Fluttertoast.showToast(
                              //         msg: e.toString(),
                              //         toastLength: Toast.LENGTH_SHORT,
                              //         gravity: ToastGravity.CENTER,
                              //         timeInSecForIosWeb: 1,
                              //         backgroundColor: Colors.blue,
                              //         textColor: Colors.white,
                              //         fontSize: 16.0);
                              //   }
                              // }
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                          //child: Text('Don\'t have an account? Create'),
                          child: Text.rich(TextSpan(children: [
                            const TextSpan(text: "Already have an account? "),
                            TextSpan(
                              text: 'Login',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()));
                                },
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).accentColor),
                            ),
                          ])),
                        ),                        
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  //   //first name field
  //   final firstNameField = TextFormField(
  //       autofocus: false,
  //       controller: firstNameEditingController,
  //       keyboardType: TextInputType.name,
  //       validator: (value) {
  //         RegExp regex = RegExp(r'^.{3,}$');
  //         if (value!.isEmpty) {
  //           return ("First Name cannot be Empty");
  //         }
  //         if (!regex.hasMatch(value)) {
  //           return ("Enter Valid name(Min. 3 Character)");
  //         }
  //         return null;
  //       },
  //       onSaved: (value) {
  //         firstNameEditingController.text = value!;
  //       },
  //       textInputAction: TextInputAction.next,
  //       decoration: InputDecoration(
  //         prefixIcon: Icon(Icons.account_circle),
  //         contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
  //         hintText: "First Name",
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //       ));

  //   //second name field
  //   final secondNameField = TextFormField(
  //       autofocus: false,
  //       controller: secondNameEditingController,
  //       keyboardType: TextInputType.name,
  //       validator: (value) {
  //         if (value!.isEmpty) {
  //           return ("Second Name cannot be Empty");
  //         }
  //         return null;
  //       },
  //       onSaved: (value) {
  //         secondNameEditingController.text = value!;
  //       },
  //       textInputAction: TextInputAction.next,
  //       decoration: InputDecoration(
  //         prefixIcon: Icon(Icons.account_circle),
  //         contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
  //         hintText: "Second Name",
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //       ));

  //   //email field
  //   final emailField = TextFormField(
  //       autofocus: false,
  //       controller: emailEditingController,
  //       keyboardType: TextInputType.emailAddress,
  //       validator: (value) {
  //         if (value!.isEmpty) {
  //           return ("Please Enter Your Email");
  //         }
  //         // reg expression for email validation
  //         if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
  //             .hasMatch(value)) {
  //           return ("Please Enter a valid email");
  //         }
  //         return null;
  //       },
  //       onSaved: (value) {
  //         firstNameEditingController.text = value!;
  //       },
  //       textInputAction: TextInputAction.next,
  //       decoration: InputDecoration(
  //         prefixIcon: Icon(Icons.mail),
  //         contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
  //         hintText: "Email",
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //       ));

  //   //password field
  //   final passwordField = TextFormField(
  //       autofocus: false,
  //       controller: passwordEditingController,
  //       obscureText: true,
  //       validator: (value) {
  //         RegExp regex = new RegExp(r'^.{6,}$');
  //         if (value!.isEmpty) {
  //           return ("Password is required for login");
  //         }
  //         if (!regex.hasMatch(value)) {
  //           return ("Enter Valid Password(Min. 6 Character)");
  //         }
  //       },
  //       onSaved: (value) {
  //         firstNameEditingController.text = value!;
  //       },
  //       textInputAction: TextInputAction.next,
  //       decoration: InputDecoration(
  //         prefixIcon: Icon(Icons.vpn_key),
  //         contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
  //         hintText: "Password",
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //       ));

  //   //confirm password field
  //   final confirmPasswordField = TextFormField(
  //       autofocus: false,
  //       controller: confirmPasswordEditingController,
  //       obscureText: true,
  //       validator: (value) {
  //         if (confirmPasswordEditingController.text !=
  //             passwordEditingController.text) {
  //           return "Password don't match";
  //         }
  //         return null;
  //       },
  //       onSaved: (value) {
  //         confirmPasswordEditingController.text = value!;
  //       },
  //       textInputAction: TextInputAction.done,
  //       decoration: InputDecoration(
  //         prefixIcon: Icon(Icons.vpn_key),
  //         contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
  //         hintText: "Confirm Password",
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //       ));

  //   //signup button
  //   final signUpButton = Material(
  //     elevation: 5,
  //     borderRadius: BorderRadius.circular(30),
  //     color: Colors.redAccent,
  //     child: MaterialButton(
  //         padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
  //         minWidth: MediaQuery.of(context).size.width,
  //         onPressed: () {
  //           signUp(emailEditingController.text, passwordEditingController.text);
  //         },
  //         child: Text(
  //           "SignUp",
  //           textAlign: TextAlign.center,
  //           style: TextStyle(
  //               fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
  //         )),
  //   );

  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     appBar: AppBar(
  //       backgroundColor: Colors.transparent,
  //       elevation: 0,
  //       leading: IconButton(
  //         icon: Icon(Icons.arrow_back, color: Colors.red),
  //         onPressed: () {
  //           // passing this to our root
  //           Navigator.of(context).pop();
  //         },
  //       ),
  //     ),
  //     body: Center(
  //       child: SingleChildScrollView(
  //         child: Container(
  //           color: Colors.white,
  //           child: Padding(
  //             padding: const EdgeInsets.all(36.0),
  //             child: Form(
  //               key: _formKey,
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: <Widget>[
  //                   SizedBox(
  //                       height: 180,
  //                       child: Image.asset(
  //                         "assets/images/logo.png",
  //                         fit: BoxFit.contain,
  //                       )),
  //                   SizedBox(height: 45),
  //                   firstNameField,
  //                   SizedBox(height: 20),
  //                   secondNameField,
  //                   SizedBox(height: 20),
  //                   emailField,
  //                   SizedBox(height: 20),
  //                   passwordField,
  //                   SizedBox(height: 20),
  //                   confirmPasswordField,
  //                   SizedBox(height: 20),
  //                   signUpButton,
  //                   SizedBox(height: 15),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
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
  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.secondName = secondNameEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => HomeFeed()),
        (route) => false);
  }
}