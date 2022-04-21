import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_signup/driver/driver_login.dart';
import 'package:login_signup/models/driver_data.dart';
import 'package:login_signup/profile2.dart';
import 'driver_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DriverUpdateProfile extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _UpdateProfileState();
  }
}

class _UpdateProfileState extends State<DriverUpdateProfile> {
  User? user = FirebaseAuth.instance.currentUser;
  DriverModel loggedInUser = DriverModel();
  late final updateFname = TextEditingController();
  late final updateSname = TextEditingController();
  late final updateEmail = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;


  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("drivers")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = DriverModel.fromMap(value.data());
      setState(() {});
    });
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.check),
                onPressed: () {
                  edit();
                }),
          ],
          title: const Text(
            'Edit Profile',
            style: TextStyle(
              color: Color.fromARGB(255, 204, 0, 0),
            ),
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
                    hintText: "${loggedInUser.driverfirstName}",
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
                    hintText: "${loggedInUser.driversecondName}",
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
                    hintText: "${loggedInUser.driverEmail}",
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
        MaterialPageRoute(builder: (context) => const DriverLogin()));
  }
}
