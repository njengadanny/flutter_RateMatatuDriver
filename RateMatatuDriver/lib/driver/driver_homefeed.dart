import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_signup/models/driver_data.dart';
import 'driver_profile.dart';
import 'driver_timeline.dart';
import '../models/driver_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../rate_history.dart';
import '../login_screen.dart';

class DriverHomeFeed extends StatefulWidget {
  const DriverHomeFeed({Key? key}) : super(key: key);

  @override
  _HomeFeedState createState() => _HomeFeedState();
}

class _HomeFeedState extends State<DriverHomeFeed> {
  User? user = FirebaseAuth.instance.currentUser;
  DriverModel loggedInUser = DriverModel();

  int _selectedIndex = 0;
  // final screens = [
  //   const DriverHomeFeed(),
  //   ProfilePage(),
  //   const RatingPage(),
  //   ProfilePage(),

  // ];
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    DriverTimeline(),
    const Text(
      'Index 1: Search',
      style: optionStyle,
    ),
    const Text(
      'Index 2: Notifications',
      style: optionStyle,
    ),
    DriverProfilePage(),
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
        .collection("drivers")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = DriverModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   iconTheme: const IconThemeData(color: Colors.black),
      //   leading: null,
      //   actions: <Widget>[
      //     IconButton(
      //         icon: const Icon(Icons.logout_rounded),
      //         color: Colors.black,
      //         onPressed: () {
      //           logout(context);
      //           //Implement logout functionality
      //         }),
      //   ],
      //   title: const Text('Home',
      //       style: TextStyle(
      //         color: Colors.black,
      //       )),
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      // ),
      // floatingActionButton:
      // FloatingActionButton(child: const Icon(Icons.add), onPressed: () {}),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      drawer: Drawer(
        elevation: 20.0,
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              onDetailsPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return DriverProfilePage();
                }));
              },
              accountName: Text("${loggedInUser.driverfirstName} \n View Profile ",
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
            // backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
            // backgroundColor: Colors.purple,
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person),
          //   label: 'Profile',
          //   backgroundColor: Colors.pink,
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,

        //   onTap: (value) {
        //   if (value == 0) Navigator.of(context).push(...);
        //   if (value == 1) Navigator.of(context).push(...);
        //   if (value == 2) Navigator.of(context).push(...);
        // },
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
      //          ActionChip(
      //              label: const Text("Logout"),
      //              onPressed: () {
      //                logout(context);
      //              }),
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
