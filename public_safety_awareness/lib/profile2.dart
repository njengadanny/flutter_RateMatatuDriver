import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'userData.dart';

class ReadExamples extends StatefulWidget {
  @override
  _ReadExampleState createState() => _ReadExampleState();
}

class _ReadExampleState extends State<ReadExamples> {
  String _displayText = 'results';
  final _database = FirebaseDatabase.instance.reference();
  late StreamSubscription _userStream;

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  void _activateListeners() {
    _userStream = _database.child("users").onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value);
      final userData = UserData.fromRTDB(data);

      // final fname = data['fname'] as String;
      // final lname = data['lname'] as String;
      // final email = data['email'] as String;
      setState(() {
        _displayText = userData.fancyDisplay();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(_displayText,
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void deactivate() {
    _userStream.cancel();
    super.deactivate();
  }
}



// class Profile extends StatefulWidget {
//   @override
//   _realtime_dbState createState() => _realtime_dbState();
// }

// class _realtime_dbState extends State<Profile> {
//   late DatabaseReference _dbref;
//   String databasejson = "";
//   int countvalue =0;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _dbref = FirebaseDatabase.instance.reference();
    
//     _dbref.child("users").onValue.listen((event) {

//       print("counter update "+ event.snapshot.value.toString());
//       setState(() {
//         countvalue = event.snapshot.value;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text( countvalue.toString()+ " database - " + databasejson),
//               ),
//               // TextButton(
//               //     onPressed: () {
//               //       _createDB();
//               //     },
//               //     child: Text(" create DB")),
//               TextButton(onPressed: () {
//                 _realdb_once();
//               }, child: Text(" view profile")),
//               TextButton(onPressed: () {
//                 _readdb_onechild();
//               }, child: Text(" read once child")),
//           //     TextButton(onPressed: () {
//           //       _updatevalue();
//           //     }, child: Text(" update value")),
//           //     TextButton(onPressed: () {
//           //       _updatevalue_count();
//           //     }, child: Text(" update counter value by 1")),
//           //  //   _updatevalue_count()
//           //     TextButton(onPressed: () {
//           //       _delete();
//           //     }, child: Text(" delete value")),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

  // _createDB() {
  //   _dbref.child("users").set(" kamal profile");
  //   _dbref.child("jobprofile").set({'website': "www.blueappsoftware.com", "website2": "www.dripcoding.com"});
  // }

  // _realdb_once() {

  //   _dbref.once().then((DataSnapshot dataSnapshot){
  //     print(" read once - "+ dataSnapshot.value.toString() );
  //     setState(() {
  //       databasejson = dataSnapshot.value.toString();
  //     });
  //   });
  // }

  // _readdb_onechild(){
  //   _dbref.child("users").child("fname").once().then((DataSnapshot dataSnapshot){
  //     print(" read once - "+ dataSnapshot.value.toString() );
  //     setState(() {
  //       databasejson = dataSnapshot.value.toString();
  //     });
  //   });
  // }

  // _updatevalue(){
  //   _dbref.child("jobprofile").update( { "website2": "www.dripcoding.com2"});
  // }

  // _updatevalue_count(){
  //   _dbref.child("myCountKey").update({ "key_counter" : countvalue +1});
  // }

  // _delete(){
  //   _dbref.child("profile").remove();
  // }
  
  
// }
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';

// class Profile extends StatefulWidget {
//   const Profile({Key? key, required this.title}) : super(key: key);
//   final String title;

//   @override
//   _Profile createState() => _Profile();
// }

// class _Profile extends State<Profile> {
//   final database = FirebaseDatabase.instance.reference().child("users");
//   List<Map<dynamic, dynamic>> lists = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("User Profile"),
//         ),
//         body: FutureBuilder(
//             future: database.once(),
//             builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
//               if (snapshot.hasData) {
//                 lists.clear();
//                 Map<dynamic, dynamic> values = snapshot.data!.value;
//                 values.forEach((key, values) {
//                   lists.add(values);
//                 });
//                 return ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: lists.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return Card(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Text("fname: " + lists[index]["fname"]),
//                             Text("lname: " + lists[index]["lname"]),
//                             Text("email: " + lists[index]["email"]),
//                           ],
//                         ),
//                       );
//                     });
//               }
//               return const CircularProgressIndicator();
//             }));
//   }
// }