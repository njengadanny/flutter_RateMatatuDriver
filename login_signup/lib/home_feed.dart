import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_signup/profile2.dart';
import 'package:login_signup/rating.dart';
import 'package:login_signup/timeline.dart';
import 'models/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'rate_history.dart';
import 'login_screen.dart';
import 'search.dart';

class HomeFeed extends StatefulWidget {
  const HomeFeed({Key? key}) : super(key: key);

  @override
  _HomeFeedState createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  int _selectedIndex = 0;
  
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    Timeline(),
    const Search2(),
    // const Text(
    //   'Index 1: Search',
    //   style: optionStyle,
    // ),
    const Text(
      'Index 2: Notifications',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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

      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.blueAccent,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.notifications),
          //   label: 'Notifications',
          //   // backgroundColor: Colors.purple,
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        
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
