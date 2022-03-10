import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

import 'models/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
   State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
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
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.grey,
        
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.logout_rounded),
              onPressed: () {
                logout(context);
                //Implement logout functionality
              }),
        ],
        title: const Text('Profile',),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.only(left: 22.0),
          //       child: Text(
          //         'Profile Details',
          //         style: GoogleFonts.lato(
          //             color: Colors.grey[800],
          //             fontSize: 26,
          //             letterSpacing: 0,
          //             fontWeight: FontWeight.bold),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(right: 15.0),
          //       child: Container(
          //         decoration: const BoxDecoration(
          //             color: Colors.blue,
          //             borderRadius: BorderRadius.all(Radius.circular(40))),
          //         child: Padding(
          //           padding: const EdgeInsets.only(
          //               left: 13, right: 20, top: 10, bottom: 10),
          //           child: Row(
          //             children: [
          //               const Icon(
          //                 Icons.logout_rounded,
          //                 color: Colors.white,
          //                 size: 16,
          //               ),
          //               const SizedBox(
          //                 width: 3,
          //               ),
          //               Text(
          //                 'Log Out',
          //                 style: GoogleFonts.lato(
          //                     color: Colors.white,
          //                     fontSize: 15,
          //                     letterSpacing: 0,
          //                     fontWeight: FontWeight.normal),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          Center(
            child: Container(
              decoration: const BoxDecoration(color: Colors.white),
              height: 180,
              child: Stack(
                children: <Widget>[
                  Container(
                      height: 108,
                      width: 101,
                      margin: const EdgeInsets.only(
                          left: 15.0, right: 15, top: 25, bottom: 5),
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(140)),
                      child: CircleAvatar(
                        child: ClipRRect(
                          borderRadius:BorderRadius.circular(30),
                          child: Image.asset("assets/images/avatar.png"),
                        )
                      )),
                  Positioned(
                    bottom: 54,
                    right: 20, //give the values according to your requirement
                    child: Material(
                        color: Colors.blue[900],
                        elevation: 10,
                        borderRadius: BorderRadius.circular(100),
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.zoom_out_map,
                            size: 18,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Text(
                  'First Name ',
                  style: GoogleFonts.lato(
                      color: Colors.grey[900],
                      fontSize: 16,
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 37.0),
                child: Text(
                  "${loggedInUser.firstName}",
                  style: GoogleFonts.lato(
                      color: Colors.grey[600],
                      fontSize: 14,
                      letterSpacing: 1,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Text(
                  'Second Name ',
                  style: GoogleFonts.lato(
                      color: Colors.grey[900],
                      fontSize: 16,
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 37.0),
                child: Text(
                  '${loggedInUser.secondName}',
                  style: GoogleFonts.lato(
                      color: Colors.grey[600],
                      fontSize: 14,
                      letterSpacing: 1,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
          // const SizedBox(
          //   height: 30,
          // ),
          // Row(
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.only(left: 24.0),
          //       child: Text(
          //         'Email ',
          //         style: GoogleFonts.lato(
          //             color: Colors.grey[900],
          //             fontSize: 16,
          //             letterSpacing: 0,
          //             fontWeight: FontWeight.bold),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(left: 14.0),
          //       child: Text(
          //         '${loggedInUser.email}',
          //         style: GoogleFonts.lato(
          //             color: Colors.grey[600],
          //             fontSize: 14,
          //             letterSpacing: 1,
          //             fontWeight: FontWeight.normal),
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(
          //   height: 30,
          // ),
          // Row(
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.only(left: 24.0),
          //       child: Text(
          //         'Location ',
          //         style: GoogleFonts.lato(
          //             color: Colors.grey[900],
          //             fontSize: 16,
          //             letterSpacing: 0,
          //             fontWeight: FontWeight.bold),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(left: 14.0),
          //       child: Text(
          //         '  Delhi, India',
          //         style: GoogleFonts.lato(
          //             color: Colors.grey[600],
          //             fontSize: 14,
          //             letterSpacing: 1,
          //             fontWeight: FontWeight.normal),
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          // const Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 22.0),
          //   child: Divider(),
          // ),
          // const SizedBox(
          //   height: 30,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     const Padding(
          //       padding: EdgeInsets.only(left: 24.0),
          //       child: Icon(Icons.person),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(left: 8.0),
          //       child: Text(
          //         'Private Information',
          //         style: GoogleFonts.lato(
          //             color: Colors.grey[700],
          //             fontSize: 17,
          //             letterSpacing: 0.5,
          //             fontWeight: FontWeight.bold),
          //       ),
          //     ),
          //   ],
          // ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Icon(Icons.mail, color: Colors.grey[500]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  '${loggedInUser.email}',
                  style: GoogleFonts.lato(
                      color: Colors.grey[700],
                      fontSize: 14,
                      letterSpacing: 1,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.only(left: 54.0),
          //       child: Icon(Icons.phone, color: Colors.grey[500]),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(left: 8.0),
          //       child: Text(
          //         '+91 - 9560419114',
          //         style: GoogleFonts.lato(
          //             color: Colors.grey[700],
          //             fontSize: 14,
          //             letterSpacing: 1,
          //             fontWeight: FontWeight.normal),
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.only(left: 54.0),
          //       child: Icon(Icons.home_outlined, color: Colors.grey[500]),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(left: 8.0),
          //       child: Text(
          //         'RZ- 5167, Hari Nagar, New Delhi',
          //         style: GoogleFonts.lato(
          //             color: Colors.grey[700],
          //             fontSize: 14,
          //             letterSpacing: 1,
          //             fontWeight: FontWeight.normal),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}