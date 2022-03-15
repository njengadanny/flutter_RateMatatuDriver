import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        title: const Text("Rate History"),
        centerTitle: true,
      ),
       body: 
      //  Column(
      //   children: [
      //     Center(
      //       child: Container(
      //         decoration: const BoxDecoration(color: Colors.white),
      //         height: 180,
      //         child: Stack(
      //           children: <Widget>[
      //             Container(
      //                 height: 108,
      //                 width: 101,
      //                 margin: const EdgeInsets.only(
      //                     left: 15.0, right: 15, top: 25, bottom: 5),
      //                 padding: const EdgeInsets.all(2.0),
      //                 decoration: BoxDecoration(
      //                     border: Border.all(color: Colors.white, width: 2),
      //                     borderRadius: BorderRadius.circular(140)),
      //                 child: CircleAvatar(
      //                   child: ClipRRect(
      //                     borderRadius:BorderRadius.circular(30),
      //                     child: Image.asset("assets/images/avatar.png"),
      //                   )
      //                 )),
      //             Positioned(
      //               bottom: 54,
      //               right: 20, //give the values according to your requirement
      //               child: Material(
      //                   color: Colors.blue[900],
      //                   elevation: 10,
      //                   borderRadius: BorderRadius.circular(100),
      //                   child: const Padding(
      //                     padding: EdgeInsets.all(5.0),
      //                     child: Icon(
      //                       Icons.zoom_out_map,
      //                       size: 18,
      //                       color: Colors.white,
      //                     ),
      //                   )),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //     Row(
      //       children: [
      //         Padding(
      //           padding: const EdgeInsets.only(left: 24.0),
      //           child: Text(
      //             'First Name ',
      //             style: GoogleFonts.lato(
      //                 color: Colors.grey[900],
      //                 fontSize: 16,
      //                 letterSpacing: 0,
      //                 fontWeight: FontWeight.bold),
      //           ),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.only(left: 37.0),
      //           child: Text(
      //             "${loggedInUser.firstName}",
      //             style: GoogleFonts.lato(
      //                 color: Colors.grey[600],
      //                 fontSize: 14,
      //                 letterSpacing: 1,
      //                 fontWeight: FontWeight.normal),
      //           ),
      //         ),
      //       ],
      //     ),
      //     const SizedBox(
      //       height: 30,
      //     ),
      //     Row(
      //       children: [
      //         Padding(
      //           padding: const EdgeInsets.only(left: 24.0),
      //           child: Text(
      //             'Second Name ',
      //             style: GoogleFonts.lato(
      //                 color: Colors.grey[900],
      //                 fontSize: 16,
      //                 letterSpacing: 0,
      //                 fontWeight: FontWeight.bold),
      //           ),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.only(left: 37.0),
      //           child: Text(
      //             '${loggedInUser.secondName}',
      //             style: GoogleFonts.lato(
      //                 color: Colors.grey[600],
      //                 fontSize: 14,
      //                 letterSpacing: 1,
      //                 fontWeight: FontWeight.normal),
      //           ),
      //         ),
      //       ],
      //     ),
          
      //     const SizedBox(
      //       height: 40,
      //     ),
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       children: [
      //         Padding(
      //           padding: const EdgeInsets.only(left: 30.0),
      //           child: Icon(Icons.mail, color: Colors.grey[500]),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.only(left: 8.0),
      //           child: Text(
      //             '${loggedInUser.email}',
      //             style: GoogleFonts.lato(
      //                 color: Colors.grey[700],
      //                 fontSize: 14,
      //                 letterSpacing: 1,
      //                 fontWeight: FontWeight.normal),
      //           ),
      //         ),
      //       ],
      //     ),
      //     const SizedBox(
      //       height: 20,
      //     ),
          
      //     Flexible(
      //       child: StreamBuilder<QuerySnapshot>(
      //         stream: historydb.collection('posts')
      //         // .orderBy('dateTime', descending: false)
      //         .where('useremail',
      //         isEqualTo: "${loggedInUser.email}")
      //         .snapshots(),
      //         builder: (context, snapshot) {
      //           if (!snapshot.hasData) {
      //             return const Center(
      //               child: CircularProgressIndicator(),
      //             );
      //           }                 
      //             return ListView.builder(
      //               itemCount: snapshot.data!.docs.length,
      //               itemBuilder: (context, index) {
      //                 DocumentSnapshot document = snapshot.data!.docs[index];

      //                   if (document.id == auth.currentUser!.uid) {
      //                     return Container(height: 0);
      //                   }                                                

      //                   return Card(
      //                 child: ListTile(
      //                   leading: Image.asset("assets/images/matatu_splash0.png", width: 60.0,),
      //                   title: Column(
      //                     children: [                            
      //                       Text("Driver Rated: " + document['driverID'], textAlign: TextAlign.center),
      //                       Text("Rating Given: " + document['starRating'], textAlign: TextAlign.center),
      //                     ],
      //                   ),
      //                   // subtitle: 
      //                   // Text(document['dateTime'], textAlign: TextAlign.center),
                        
      //                 ));
      //                 });
                
      //         },
      //       ),
      //     ),
      //   ],
      // ), 
      StreamBuilder<QuerySnapshot>(
        stream: historydb.collection('ratings')
        .where('useremail',
        isEqualTo: "${loggedInUser.email}")
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
                  
                    return Card(
                      child: ListTile(
                        leading: Image.asset("assets/images/matatu_splash0.png", width: 60.0,),
                        title: Column(
                          children: [                            
                            Text("Driver Rated: " + document['driverID'], textAlign: TextAlign.center),
                            Text("Rating Given: " + document['starRating'], textAlign: TextAlign.center),
                          ],
                        ),
                        // subtitle: 
                        // Text(document['dateTime'], textAlign: TextAlign.center),
                        
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
          
        },
      ),
    );
  }
}
