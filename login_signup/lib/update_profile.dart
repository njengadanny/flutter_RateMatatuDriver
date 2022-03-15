import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_signup/profil.dart';
import 'package:login_signup/profile2.dart';
import 'designs/textfield_widget.dart';
import 'login_screen.dart';
import 'models/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateProfile extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _UpdateProfileState();
  }
}

class _UpdateProfileState extends State<UpdateProfile> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  late final updateFname = TextEditingController();
  late final updateSname = TextEditingController();
  late final updateEmail = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;


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

  //  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getData()async {
  //    User user = FirebaseAuth.instance.currentUser!;
  //    return FirebaseFirestore.instance.collection('posts')
  //    .where("useremail", isEqualTo: loggedInUser.email).snapshots();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: true,
          elevation: 0,
          backgroundColor: Colors.grey,
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.check),
                onPressed: () {
                  edit();
                }),
          ],
          title: const Text(
            'Edit Profile',
          ),
        ),         
        body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 24),
              Text(
                "First Name",
                style: GoogleFonts.lato(
                    color: Colors.grey[900],
                    fontSize: 16,
                    letterSpacing: 0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: updateFname,
                decoration: InputDecoration(
                    hintText: "${loggedInUser.firstName}",
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                onSaved: (value) {
                  setState(() {
                    updateFname.text = value!;
                  });
                },
              ),
              const SizedBox(height: 24),
              Text(
                'Second Name',
                style: GoogleFonts.lato(
                    color: Colors.grey[900],
                    fontSize: 16,
                    letterSpacing: 0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: updateSname,
                decoration: InputDecoration(
                    hintText: "${loggedInUser.secondName}",
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                onSaved: (value) {
                  setState(() {
                    updateSname.text = value!;
                  });
                },
              ),
              const SizedBox(height: 24),
              Text(
                'Email',
                style: GoogleFonts.lato(
                    color: Colors.grey[900],
                    fontSize: 16,
                    letterSpacing: 0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: updateEmail,
                decoration: InputDecoration(
                    hintText: "${loggedInUser.email}",
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                onSaved: (value) {
                  setState(() {
                    updateEmail.text = value!;
                  });
                },
              )
            ]));
    //       const SizedBox(height: 24),
    //       TextFieldWidget(
    //         label: 'Second Name',
    //         text: "${loggedInUser.secondName}",
    //         onChanged: (secondName) {},
    //       ),
    //       const SizedBox(height: 24),
    //       TextFieldWidget(
    //         label: 'Email',
    //         text: "${loggedInUser.email}",
    //         onChanged: (email) {},
    //       ),
    //     ],
    //   ),
    // );

    // );
    // );
    // return Scaffold(
    //   appBar: AppBar(
    //     automaticallyImplyLeading: false,
    //     elevation: 0,
    //     backgroundColor: Colors.grey,
    //     actions: <Widget>[
    //       IconButton(
    //           icon: const Icon(Icons.check),
    //           onPressed: () {
    //             // update(context);
    //           }),
    //     ],
    //     title: const Text(
    //       'Profile',
    //     ),
    //   ),
    //   body: Column(
    //     children: [
    //       Center(
    //         child: Container(
    //           decoration: const BoxDecoration(color: Colors.white),
    //           height: 180,
    //           child: Stack(
    //             children: <Widget>[
    //               Container(
    //                   height: 108,
    //                   width: 101,
    //                   margin: const EdgeInsets.only(
    //                       left: 15.0, right: 15, top: 25, bottom: 5),
    //                   padding: const EdgeInsets.all(2.0),
    //                   decoration: BoxDecoration(
    //                       border: Border.all(color: Colors.white, width: 2),
    //                       borderRadius: BorderRadius.circular(140)),
    //                   child: CircleAvatar(
    //                       child: ClipRRect(
    //                     borderRadius: BorderRadius.circular(30),
    //                     child: Image.asset("assets/images/avatar.png"),
    //                   ))),
    //               Positioned(
    //                 bottom: 54,
    //                 right: 20, //give the values according to your requirement
    //                 child: Material(
    //                     color: Colors.blue[900],
    //                     elevation: 10,
    //                     borderRadius: BorderRadius.circular(100),
    //                     child: const Padding(
    //                       padding: EdgeInsets.all(5.0),
    //                       child: Icon(
    //                         Icons.zoom_out_map,
    //                         size: 18,
    //                         color: Colors.white,
    //                       ),
    //                     )),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       Row(
    //         children: [
    //           const SizedBox(height: 24),
    //           TextFieldWidget(
    //               label: 'First Name',
    //               text: "${loggedInUser.firstName}",
    //               onChanged: (name) {},
    //             ),

    //           // Padding(
    //           //   padding: const EdgeInsets.only(left: 24.0),
    //           //   child: Text(
    //           //     'First Name ',
    //           //     style: GoogleFonts.lato(
    //           //         color: Colors.grey[900],
    //           //         fontSize: 16,
    //           //         letterSpacing: 0,
    //           //         fontWeight: FontWeight.bold),
    //           //   ),
    //           // ),
    //           // Padding(
    //           //   padding: const EdgeInsets.only(left: 37.0),
    //           //   child: Text(
    //           //     "${loggedInUser.firstName}",
    //           //     style: GoogleFonts.lato(
    //           //         color: Colors.grey[600],
    //           //         fontSize: 14,
    //           //         letterSpacing: 1,
    //           //         fontWeight: FontWeight.normal),
    //           //   ),
    //           // ),
    //         ],
    //       ),
    //       const SizedBox(
    //         height: 30,
    //       ),
    //       Row(
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.only(left: 24.0),
    //             child: Text(
    //               'Second Name ',
    //               style: GoogleFonts.lato(
    //                   color: Colors.grey[900],
    //                   fontSize: 16,
    //                   letterSpacing: 0,
    //                   fontWeight: FontWeight.bold),
    //             ),
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.only(left: 37.0),
    //             child: Text(
    //               '${loggedInUser.secondName}',
    //               style: GoogleFonts.lato(
    //                   color: Colors.grey[600],
    //                   fontSize: 14,
    //                   letterSpacing: 1,
    //                   fontWeight: FontWeight.normal),
    //             ),
    //           ),
    //         ],
    //       ),
    //       const SizedBox(
    //         height: 40,
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.only(left: 30.0),
    //             child: Icon(Icons.mail, color: Colors.grey[500]),
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.only(left: 8.0),
    //             child: Text(
    //               '${loggedInUser.email}',
    //               style: GoogleFonts.lato(
    //                   color: Colors.grey[700],
    //                   fontSize: 14,
    //                   letterSpacing: 1,
    //                   fontWeight: FontWeight.normal),
    //             ),
    //           ),
    //         ],
    //       ),
    //       const SizedBox(
    //         height: 20,
    //       ),
    //     ],
    //   ),
    // );
  }


  void edit() async {
    var firebaseUser = FirebaseAuth.instance.currentUser!;
    
    FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser.uid)
        .update({
      "firstName": updateFname.text,
      "secondName": updateSname.text,
      "email": updateEmail.text
    }).then((_) {
      print("profile updated!");
    });

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => ProfilePage()),
        (route) => false);
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
