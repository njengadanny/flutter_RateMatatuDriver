import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class HomeFeed extends StatefulWidget {
  const HomeFeed({Key? key}) : super(key: key);

  @override
  _HomeFeedState createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> {
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
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.logout_rounded),
              onPressed: () {
                logout(context);
                //Implement logout functionality
              }),
        ],
        title: const Text('Home'),
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton:
      FloatingActionButton(child: const Icon(Icons.edit), onPressed: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      drawer: Drawer(
        elevation: 20.0,
        child: Column(
          children:  <Widget>[
            UserAccountsDrawerHeader(
              onDetailsPressed: () {
                Navigator.pushNamed(context, 'profile');
              },
              accountName: Text("${loggedInUser.firstName} \n View Profile ",
                    style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  )
                ),
              accountEmail: null,
              currentAccountPicture: CircleAvatar(
                radius: 30.0,
                // backgroundImage: NetworkImage("assets/images/logo.png"),
                backgroundColor: Colors.transparent,
                child: ClipRRect(
                  borderRadius:BorderRadius.circular(30),
                  child: Image.asset("assets/images/avatar.png"),
                )
                // child: const Text(""),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'rating');
              },
              title: const Text("Rate"),
              leading: const Icon(Icons.rate_review),
            ),
            const Divider(
              height: 0.1,
            ),
            const ListTile(
              title: Text("Rate"),
              leading: Icon(Icons.inbox),
            ),
            const ListTile(
              title: Text("Support"),
              leading: Icon(Icons.people),
            ),
            const ListTile(
              title: Text("About"),
              leading: Icon(Icons.local_offer),
            ),
          ],
        ),
      ),

      // body: Center(
      //   child: Padding(
      //     padding: const EdgeInsets.all(20),
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: <Widget>[
      //         SizedBox(
      //           height: 150,
      //           child: Image.asset("assets/images/logo.png", fit: BoxFit.contain),
      //         ),
      //         const Text(
      //           "Welcome Back",
      //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //         ),
      //         const SizedBox(
      //           height: 10,
      //         ),
      //         Text("${loggedInUser.firstName} ${loggedInUser.secondName}",
      //             style: const TextStyle(
      //               color: Colors.black54,
      //               fontWeight: FontWeight.w500,
      //             )),
      //         Text("${loggedInUser.email}",
      //             style: const TextStyle(
      //               color: Colors.black54,
      //               fontWeight: FontWeight.w500,
      //             )),
      //         const SizedBox(
      //           height: 15,
      //         ),
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