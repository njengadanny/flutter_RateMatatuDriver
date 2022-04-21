import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_signup/profile2.dart';
import 'package:login_signup/rate_history.dart';
import 'package:login_signup/rating.dart';
import '../models/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../login_screen.dart';

class Search2 extends StatefulWidget {
  const Search2({Key? key}) : super(key: key);

  @override
  _Search2State createState() => _Search2State();
}


class _Search2State extends State<Search2> {
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
      drawer: Drawer(
        elevation: 20.0,
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              onDetailsPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return ProfilePage();
                }));
              },
              accountName: Text("${loggedInUser.firstName} \t\t\t View Profile ",
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  )),
              accountEmail: null,
              currentAccountPicture: CircleAvatar(
                  radius: 30.0,
                  // backgroundImage: NetworkImage("assets/images/logo.png"),
                  backgroundColor: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset("assets/images/avatar.png"),
                  )
                  // child: const Text(""),
                  ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                return const RatingPage();  }));
              },
              title: const Text("Rate"),
              leading: const Icon(Icons.rate_review),
            ),
            const Divider(
              height: 0.1,
            ),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                return RateHistory();  }));
              },
              title: const Text("Rate History"),
              leading: const Icon(Icons.access_time),
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            floating: true,
            pinned: true,
            snap: false,
            centerTitle: false,
            title: const Text('Search',
              style: TextStyle(
                color: Colors.black,
              )),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {},
              ),
            ],
            bottom: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              title: Container(
                width: double.infinity,
                height: 40,
                color: Colors.white,
                child: const Center(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search using routes...',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Other Sliver Widgets
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    onTap: () {
                      // Navigator.pushNamed(context, 'all_users');
                    },
                    title: Column(
                      children: const [
                        Text("Nairobi/Nakuru Route",
                            textAlign: TextAlign.center,
                            style: TextStyle(height: 1.5)),
                      ],
                    ),
                  ),
                ),
              ),
              // const SizedBox(height: 15),
              Container(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      onTap: () {
                        // Navigator.pushNamed(context, 'all_users');
                      },
                      title: Column(
                        children: const [
                          Text("Nairobi/Nyeri Route",
                              textAlign: TextAlign.center,
                              style: TextStyle(height: 1.5)),
                        ],
                      ),
                    ),
                  ))
            ]),
          ),
        ],
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
