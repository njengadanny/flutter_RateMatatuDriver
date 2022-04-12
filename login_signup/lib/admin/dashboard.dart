import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import '../models/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../login_screen.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  late int numberOfUsers;

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

  // QuerySnapshot _myDoc = await FirebaseFirestore.instance.collection("users").get();
  // List<DocumentSnapshot> myDocCount = _myDoc.docs;
  // numberOfUsers = myDocCount.length.toString();

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
            )),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FutureBuilder(
                  future: FirebaseFirestore.instance.collection("ratings").get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List myDocCount = (snapshot.data as QuerySnapshot).docs;
                      var totalUsers = myDocCount.length.toString();
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListTile(
                          // onTap: () {
                          //   Navigator.pushNamed(context, 'all_users');
                          // },
                          title: Column(
                            children: [
                              Text(
                                    "Number of Ratings: " + totalUsers.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(height: 1.5)),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                const SizedBox(height: 15),
                FutureBuilder(
                  future: FirebaseFirestore.instance.collection("users").get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List myDocCount = (snapshot.data as QuerySnapshot).docs;
                      var totalUsers = myDocCount.length.toString();
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, 'all_users');
                          },
                          title: Column(
                            children: [
                              Text(
                                    "Number of Users: " + totalUsers.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(height: 1.5)),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                const SizedBox(height: 15),
                FutureBuilder(
                  future: FirebaseFirestore.instance.collection("driver_ratings").where('avgRating', isGreaterThan: "4.4").get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List myDocCount = (snapshot.data as QuerySnapshot).docs;
                      var totalUsers = myDocCount.length.toString();
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, 'top_drivers');
                          },
                          title: Column(
                            children: [
                              Text(
                                    "Top drivers: " + totalUsers.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(height: 1.5)),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                const SizedBox(height: 15),
                FutureBuilder(
                  future: FirebaseFirestore.instance.collection("drivers").get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List myDocCount = (snapshot.data as QuerySnapshot).docs;
                      var totalUsers = myDocCount.length.toString();
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, 'all_drivers');
                          },
                          title: Column(
                            children: [
                              Text(
                                    "Number of Drivers: " + totalUsers.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(height: 1.5)),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                
              ],
            ),
          ),
        ),
      );
  }
  
  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
