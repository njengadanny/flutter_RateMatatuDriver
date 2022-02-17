import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:public_safety_awareness/login_page.dart';
import 'rounded_button.dart';
import 'theme_helper.dart';
import 'header_widget.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String lname;
  late String fname;
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  final database = FirebaseDatabase.instance.reference();

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
                            onChanged: (val) {
                              fname = val;
                            },
                            decoration: ThemeHelper().textInputDecoration(
                                'First Name', 'Enter your first name'),
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter first name';
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: TextFormField(
                            onChanged: (val) {
                              lname = val;
                            },
                            decoration: ThemeHelper().textInputDecoration(
                                'Last Name', 'Enter your last name'),
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter last name';
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (val) {
                              email = val.toString().trim();
                              //Do something with the user input.
                            },
                            decoration: ThemeHelper().textInputDecoration(
                                "E-mail address", "Enter your email"),
                            validator: (val) {
                              if (!(val!.isEmpty) &&
                                  !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                      .hasMatch(val)) {
                                return "Enter a valid email address";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            obscureText: true,
                            onChanged: (val) {
                              password = val;
                              //Do something with the user input.
                            },
                            decoration: ThemeHelper().textInputDecoration(
                                "Password*", "Enter your password"),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter your password";
                              }
                              return null;
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
                              final newUser = <String, dynamic>{
                                'fname': fname,
                                'lname': lname,
                                'email': email,
                                'time': DateTime.now().millisecondsSinceEpoch
                              };
                              database
                              .child('users')
                              .push()
                              .set(newUser)
                              .then((_) => print('new user added'))
                              .catchError(
                                (error) => print('this is the error $error')
                              );
                              if (_formKey.currentState!.validate()) {
                                try {
                                  final newUser = await _auth
                                      .createUserWithEmailAndPassword(
                                          email: email, password: password);
                                  if (newUser != null) {
                                    Navigator.pushNamed(context, 'login');
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
                                      fontSize: 16.0);
                                }
                              }
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
                                              const LoginPage()));
                                },
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).accentColor),
                            ),
                          ])),
                        ),
                        // SizedBox(height: 10.0),
                        // Text("Or create account using social media",  style: TextStyle(color: Colors.grey),),
                        // SizedBox(height: 25.0),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     GestureDetector(
                        //       child: FaIcon(
                        //         FontAwesomeIcons.googlePlus, size: 35,
                        //         color: HexColor("#EC2D2F"),),
                        //       onTap: () {
                        //         setState(() {
                        //           showDialog(
                        //             context: context,
                        //             builder: (BuildContext context) {
                        //               return ThemeHelper().alartDialog("Google Plus","You tap on GooglePlus social icon.",context);
                        //             },
                        //           );
                        //         });
                        //       },
                        //     ),
                        //     SizedBox(width: 30.0,),
                        //     GestureDetector(
                        //       child: Container(
                        //         padding: EdgeInsets.all(0),
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(100),
                        //           border: Border.all(width: 5, color: HexColor("#40ABF0")),
                        //           color: HexColor("#40ABF0"),
                        //         ),
                        //         child: FaIcon(
                        //           FontAwesomeIcons.twitter, size: 23,
                        //           color: HexColor("#FFFFFF"),),
                        //       ),
                        //       onTap: () {
                        //         setState(() {
                        //           showDialog(
                        //             context: context,
                        //             builder: (BuildContext context) {
                        //               return ThemeHelper().alartDialog("Twitter","You tap on Twitter social icon.",context);
                        //             },
                        //           );
                        //         });
                        //       },
                        //     ),
                        //     SizedBox(width: 30.0,),
                        //     GestureDetector(
                        //       child: FaIcon(
                        //         FontAwesomeIcons.facebook, size: 35,
                        //         color: HexColor("#3E529C"),),
                        //       onTap: () {
                        //         setState(() {
                        //           showDialog(
                        //             context: context,
                        //             builder: (BuildContext context) {
                        //               return ThemeHelper().alartDialog("Facebook",
                        //                   "You tap on Facebook social icon.",
                        //                   context);
                        //             },
                        //           );
                        //         });
                        //       },
                        //     ),
                        //   ],
                        // ),
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

  /* @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              GestureDetector(
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                            width: 5, color: Colors.white),
                        color: Colors.white,
                        boxShadow:  const [
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
                      padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
                      child: Icon(
                        Icons.add_circle,
                        color: Colors.grey.shade700,
                        size: 25.0,
                      ),
                    ),
                  ],
                ),
              ),
              TextFormField(
                textAlign: TextAlign.center,

                onChanged: (value) {
                  fname = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'First name'),
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Please enter first name";
                  }
                  return null;
                },
              ),

              TextFormField(
                textAlign: TextAlign.center,

                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Last name'),
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Please enter last name";
                  }
                  return null;
                },
                  onChanged: (value) {
                lname = value;
              },
              ),



              TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  validator: (val) {
                    if(!(val!.isEmpty) && !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(val)){
                      return "Enter a valid email address";
                    }
                    return null;
                  },
                  // validator: (value) => (value!.isEmpty)
                  //     ? ' Please enter email'
                  //     : null,
                  onChanged: (value) {
                    email = value.toString().trim();
                    //Do something with the user input.
                  },

                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email')),
               SizedBox(
                height: 8.0,
              ),
              TextFormField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter Password";
                    }
                  },
                  onChanged: (value) {
                    password = value;
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your Password')),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                colour: Colors.blueAccent,
                title: 'Sign Up',
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      Navigator.pushNamed(context, 'home_feed');
                    }
                  } catch (e) {
                    print(e);
                  }
                  setState(() {
                    showSpinner = false;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }*/
}
