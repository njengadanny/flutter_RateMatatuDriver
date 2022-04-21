import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/driver/driver_registration.dart';

import 'edituser.dart';

class AllDrivers extends StatelessWidget {
  final db = FirebaseFirestore.instance;

  FirebaseAuth auth = FirebaseAuth.instance;

  AllDrivers({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Drivers",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      floatingActionButton:
      FloatingActionButton(child: const Icon(Icons.add), onPressed: () { 
        Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => DriverRegistration()));
      }),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('drivers')
        .orderBy('driverEmail')
        .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = snapshot.data!.docs[index];

                  if (document.id == auth.currentUser!.uid) {
                    return Container(height: 0);
                  }
                  
                    return Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                      child: ListTile(
                        leading: Image.asset("assets/images/driveravatar.png", width: 60.0,),
                        title: Column(
                          children: [
                            Text("First Name: " + document['firstName'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(height: 1.5)),
                          Text("Second Name: " + document['secondName'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(height: 1.5)),
                        ],
                      ),
                      subtitle: Text("Email: " + document['driverEmail'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(height: 1.5)),
                      trailing: Wrap(
                        // spacing: 12, // space between two icons
                        children: <Widget>[
                          IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>  EditUser(key: null, uid: '',)));
                              }), 
                          IconButton(
                              icon: const Icon(Icons.delete,color: Colors.red,),
                              onPressed: () async => await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                              myTransaction.delete(snapshot.data!.docs[index].reference);
                          }),) 
                        ],
                      ),
                        // trailing:  IconButton(
                        //       onPressed: () async => await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                        //       myTransaction.delete(snapshot.data!.docs[index].reference);
                        //   }),
                        //       icon: const Icon(
                        //         Icons.delete,
                        //         color: Colors.red,
                        //       ),
                        //     ),
                      ),
                    );
                });
          }
        },
      ),
    );
  }
}
