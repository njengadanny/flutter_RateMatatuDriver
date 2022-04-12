import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_signup/models/driver_data.dart';
import '../models/driver_rating.dart';

class DriverReputation extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _DriverReputationState();
  }
}

class _DriverReputationState extends State<DriverReputation> {
  User? user = FirebaseAuth.instance.currentUser;
  DriverModel loggedInUser = DriverModel();
  final reputationdb = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

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
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Reputation Score',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        // bottom: const PreferredSize(
        // child: Text("Rating History",
        // style: TextStyle(
        //     color: Colors.black,
        //   ),),
        // preferredSize: Size.fromHeight(20.0)),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      
      
      body: StreamBuilder<QuerySnapshot>(
        stream: reputationdb
            .collection('driver_ratings')
            .where('driverID', isEqualTo: loggedInUser.driverID)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = snapshot.data!.docs[index];

                if (document.id == auth.currentUser!.uid) {
                  return Container(height: 0);
                }

                const SizedBox(
                  height: 30,
                );

                return Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    leading: Image.asset(
                      "assets/images/driveravatar.png",
                      width: 60.0,
                    ),
                    title: Column(
                      children: [
                        Text("Email: " "${loggedInUser.driverEmail}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(height: 1.5)),
                        Text("Driver ID: " + document['driverID'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(height: 1.5)),
                        Text("Average Rating: " + document['avgRating'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(height: 1.5)),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
