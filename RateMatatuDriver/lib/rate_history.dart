import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'models/user_data.dart';

class RateHistory extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _RateHistoryState();
  }
}

class _RateHistoryState extends State<RateHistory> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final historydb = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Rating History',
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
        stream: historydb
            .collection('ratings')
            .where('useremail', isEqualTo: "${loggedInUser.email}")
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
                      "assets/images/matatu_splash0.png",
                      width: 60.0,
                    ),
                    title: Column(
                      children: [
                        Text("Driver Rated: " + document['driverID'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(height: 1.5)),
                        Text("Rating Given: " + document['starRating'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(height: 1.5)),
                        Text("Route Taken: " + document['route'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(height: 1.5)),
                      ],
                    ),
                    subtitle: Text(document['dateTime'].toDate().toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(height: 1.5)),
                  ),
                );
              });
        },
      ),
    );
  }
}
