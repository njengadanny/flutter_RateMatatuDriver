import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'designs/styles.dart';
import 'models/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'designs/theme_helper.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.logout_rounded),
              color: Colors.black,
              onPressed: () {
                logout(context);
                //Implement logout functionality
              }),
        ],
        title: const Text('Dashboard',
          style: TextStyle(
            color: Colors.black,
          )
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Color(0xFF3594DD),
                Color(0xFF4563DB),
                Color(0xFF5036D5),
                Color(0xFF5B16D0),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            // Expanded(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ThemeHelper().buttonStyle(),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: Text(
                        'Top Drivers'.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    onPressed: () async {
                      Navigator.pushNamed(context, 'ratings');
                    },
                  ),
                ),
                const SizedBox(height: 45),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ThemeHelper().buttonStyle(),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: Text(
                        'Manage Drivers'.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    onPressed: () async {
                      Navigator.pushNamed(context, 'all_users');
                    },
                  ),
                ),
                
                // changed from 600 to 500
                // Container(
                //   height: 500.0,
                //   child: PageView(
                //     physics: const ClampingScrollPhysics(),
                //     controller: _pageController,
                //     onPageChanged: (int page) {
                //       setState(() {
                //         _currentPage = page;
                //       });
                //     },
                //     children: <Widget>[
                //       Padding(
                //         padding: const EdgeInsets.all(30.0),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: const <Widget>[
                //             Center(
                //               child: Image(
                //                 image: AssetImage(
                //                   'assets/images/post.png',
                //                 ),
                //                 height: 250.0,
                //                 width: 250.0,
                //               ),
                //             ),
                //             SizedBox(height: 30.0),
                //             Text(
                //               'Community policing',
                //               style: kTitleStyle,
                //             ),
                //             SizedBox(height: 15.0),
                //             Text(
                //               'Post updates about your trips and report drivers who do not follow the law.',
                //               style: kSubtitleStyle,
                //             ),
                //           ],
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.all(40.0),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: const <Widget>[
                //             Center(
                //               child: Image(
                //                 image: AssetImage(
                //                   'assets/images/onboarding1.png',
                //                 ),
                //                 height: 200.0,
                //                 width: 200.0
                //               ),
                //             ),
                //             SizedBox(height: 30.0),
                //             Text(
                //               'Be in the know!',
                //               style: kTitleStyle,
                //             ),
                //             SizedBox(height: 15.0),
                //             Text(
                //               ' With other users posting updates about the route you are on, you will always be in the know ',
                //               style: kSubtitleStyle,
                //             ),
                //           ],
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.all(30.0),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: const <Widget>[
                //             Center(
                //               child: Image(
                //                 image: AssetImage(
                //                   'assets/images/feedback1.png',
                //                 ),
                //                 height: 250.0,
                //                 width: 250.0
                //               ),
                //             ),
                //             SizedBox(height: 20.0),
                //             Text(
                //               'Give feedback after trip',
                //               style: kTitleStyle,
                //             ),
                //             SizedBox(height: 10.0),
                //             Text(
                //               ' After each trip, you will be able to rate the driving and give feedback on your experience',
                //               style: kSubtitleStyle,
                //             ),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: _buildPageIndicator(),
                // ),
                // _currentPage != _numPages - 1
                    // ? Expanded(
                //         child: Align(
                //           alignment: FractionalOffset.bottomRight,
                //           child: TextButton(
                //             onPressed: () {
                //               _pageController.nextPage(
                //                 duration: const Duration(milliseconds: 500),
                //                 curve: Curves.ease,
                //               );
                //             },
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               mainAxisSize: MainAxisSize.min,
                //               children: const <Widget>[
                //                 Text(
                //                   'Next',
                //                   style: TextStyle(
                //                     color: Colors.white,
                //                     fontSize: 22.0,
                //                   ),
                //                 ),
                //                 SizedBox(width: 10.0),
                //                 Icon(
                //                   Icons.arrow_forward,
                //                   color: Colors.white,
                //                   size: 25.0,
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //       )
                    // : const Text(''),
              ],
            ),
          ),
        ),
      ),
      // body:  Center(
      //   child: Padding(
      //     padding: const EdgeInsets.all(20),
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: <Widget>[
      //         Container(
      //             decoration: ThemeHelper().buttonBoxDecoration(context),
      //           child: ElevatedButton(
      //             style: ThemeHelper().buttonStyle(),
      //             child: Padding(
      //               padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      //               child: Text(
      //                 'View Driver Ratings'.toUpperCase(),
      //                 style: const TextStyle(
      //                     fontSize: 20,
      //                     fontWeight: FontWeight.bold,
      //                     color: Colors.white),
      //               ),
      //             ),
      //             onPressed: () async {
      //               Navigator.pushNamed(context, 'ratings');
      //             },
      //           ),
      //         ),
      //         const SizedBox(height: 45),
      //         Container(
      //             decoration: ThemeHelper().buttonBoxDecoration(context),
      //           child: ElevatedButton(
      //             style: ThemeHelper().buttonStyle(),
      //             child: Padding(
      //               padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      //               child: Text(
      //                 'Top drivers'.toUpperCase(),
      //                 style: const TextStyle(
      //                     fontSize: 20,
      //                     fontWeight: FontWeight.bold,
      //                     color: Colors.white),
      //               ),
      //             ),
      //             onPressed: () async {
      //               Navigator.pushNamed(context, 'ratings');
      //             },
      //           ),
      //         ),
      //         // const Text(
      //         //   "Welcome Back",
      //         //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //         // ),
      //         // const SizedBox(
      //         //   height: 10,
      //         // ),
      //         // Text("${loggedInUser.firstName} ${loggedInUser.secondName}",
      //         //     style: const TextStyle(
      //         //       color: Colors.black54,
      //         //       fontWeight: FontWeight.w500,
      //         //     )),
      //         // Text("${loggedInUser.email}",
      //         //     style: const TextStyle(
      //         //       color: Colors.black54,
      //         //       fontWeight: FontWeight.w500,
      //         //     )),
      //         // const SizedBox(
      //         //   height: 15,
      //         // ),
      //         // ActionChip(
      //         //     label: const Text("Logout"),
      //         //     onPressed: () {
      //         //       logout(context);
      //         //     }),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}