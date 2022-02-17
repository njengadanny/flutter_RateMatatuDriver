import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:public_safety_awareness/models/user_data.dart';
import 'signup_screen.dart';
import 'package:firebase_database/firebase_database.dart';

late User loggedinUser = UserData(fname: '', email: '', lname: '') as User;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _displayText = '';
  late User user;  
  late String fname, lname;
  final _auth = FirebaseAuth.instance;
  final _database = FirebaseDatabase.instance.reference();


  Future<void> getUserData() async {
    User userData = await FirebaseAuth.instance.currentUser;
    setState(() {
      user = userData;
      print(userData.email);
    });
  }
  void initState() {
    super.initState();
    getCurrentUser();
    // _activateListeners();
    // getUserData();
  }

  // void _activateListeners() {
  //   _database.child('users').onValue.listen((event) {
  //     final String fname = event.snapshot.value;
  //     setState(() {
  //       _displayText = fname;
  //     });
  //   });
  // }

  //using this function you can use the credentials of the user
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedinUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

    
  // getCurrentUser() async {
  //   final User user = _auth.currentUser;
  //   final uid = user.uid;
  //   // Similarly we can get email as well
  //   //final uemail = user.email;
  //   print(uid);
  //   //print(uemail);
  // }

  Future<String> getUsername() async {
    final ref = FirebaseDatabase.instance.reference();
    var firebaseAuth;
    User userRef = await firebaseAuth.currentUser;

    return ref.child('users').child(userRef.uid).once().then((DataSnapshot snap) {
      final String fname = snap.value['fname'].toString();
      print(fname);
      return fname;
    });
  }

  @override
  Widget build(BuildContext context) {
    final database = FirebaseDatabase.instance
        .reference()
        .child('users')
        .once();
    database.then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key,values) {
        print(values["fname"+ snapshot.value.toString()]);
      });
    });
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.logout_rounded),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);

                //Implement logout functionality
              }),
        ],
        title: const Text('Home'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      drawer: Drawer(
        elevation: 20.0,
        child: Column(
          children:  <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text("fname"),
              accountEmail: Text('View Profile'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Text(""),
              ),
            ),
            ListTile(
              title: TextButton(
                onPressed: () {
                      getCurrentUser;
                      Navigator.pushNamed(context, 'profile');
                    }, child: const Text("Profile"),
              ),
              leading: const Icon(Icons.person),
              
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
      body:  Center(
        child: Text(
          "Welcome User" + loggedinUser.displayName,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
