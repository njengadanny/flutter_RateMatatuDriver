import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/driver/driver_registration.dart';
import 'package:login_signup/registration_screen.dart';

class AllUsers extends StatelessWidget {
  final db = FirebaseFirestore.instance;

  FirebaseAuth auth = FirebaseAuth.instance;

  AllUsers({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Users",
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
                      MaterialPageRoute(builder: (context) => RegistrationScreen()));
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('users').orderBy('email').snapshots(),
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
                        leading: Image.asset("assets/images/avatar.png", width: 60.0,),
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
                      subtitle: Text("Email: " + document['email'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(height: 1.5)),
                        trailing:  IconButton(
                              onPressed: () async => await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                              myTransaction.delete(snapshot.data!.docs[index].reference);
                          }),
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                      ),
                    );
                });
                
            // return ListView(
            //   children: snapshot.data!.docs.map((doc) {
            //     return Card(
            //       child: ListTile(
            //         title: Text("First Name: "+ doc['firstName']),
            //         subtitle: Text("Email: " + doc['email']),
            //       ),
            //     );
            //   }).toList(),
            // );
          }
        },
      ),
    );
  }
}
