import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_signup/profil.dart';
import 'driver_login.dart';
import '../models/driver_data.dart';
import 'driver_updateprofile.dart';


class DriverProfilePage extends StatefulWidget {
   State<StatefulWidget> createState() {
    return _DriverProfilePageState();
  }
}

class _DriverProfilePageState extends State<DriverProfilePage> {
  User? user = FirebaseAuth.instance.currentUser;
  DriverModel loggedInUser = DriverModel();
  final postdb = FirebaseFirestore.instance;
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
        // automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.logout_rounded),
              onPressed: () {
                logout(context);
                //Implement logout functionality
              }),
        ],
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      floatingActionButton:
      FloatingActionButton(child: const Icon(Icons.edit), onPressed: () { 
        Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => DriverUpdateProfile()));
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: Colors.white,

      body: Column(
        children: [          
          Center(
            child: Container(
              decoration: const BoxDecoration(color: Colors.white),
              height: 180,
              child: Stack(
                children: <Widget>[
                  Container(
                      height: 108,
                      width: 101,
                      margin: const EdgeInsets.only(
                          left: 15.0, right: 15, top: 25, bottom: 5),
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(140)),
                      child: CircleAvatar(
                        child: ClipRRect(
                          borderRadius:BorderRadius.circular(30),
                          child: Image.asset("assets/images/avatar.png"),
                        )
                      )),
                  Positioned(
                    bottom: 54,
                    right: 20, //give the values according to your requirement
                    child: Material(
                        color: Colors.blue[900],
                        elevation: 10,
                        borderRadius: BorderRadius.circular(100),
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.zoom_out_map,
                            size: 18,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Text(
                  'First Name ',
                  style: GoogleFonts.lato(
                      color: Colors.grey[900],
                      fontSize: 16,
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 37.0),
                child: Text(
                  "${loggedInUser.driverfirstName}",
                  style: GoogleFonts.lato(
                      color: Colors.grey[600],
                      fontSize: 14,
                      letterSpacing: 1,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Text(
                  'Second Name ',
                  style: GoogleFonts.lato(
                      color: Colors.grey[900],
                      fontSize: 16,
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 37.0),
                child: Text(
                  '${loggedInUser.driversecondName}',
                  style: GoogleFonts.lato(
                      color: Colors.grey[600],
                      fontSize: 14,
                      letterSpacing: 1,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Text(
                  'Your ID',
                  style: GoogleFonts.lato(
                      color: Colors.grey[900],
                      fontSize: 16,
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 37.0),
                child: Text(
                  '${loggedInUser.driverID}',
                  style: GoogleFonts.lato(
                      color: Colors.grey[600],
                      fontSize: 14,
                      letterSpacing: 1,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Icon(Icons.mail, color: Colors.grey[500]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  '${loggedInUser.driverEmail}',
                  style: GoogleFonts.lato(
                      color: Colors.grey[700],
                      fontSize: 14,
                      letterSpacing: 1,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),          
          Flexible(
            child: StreamBuilder<QuerySnapshot>(
              stream: postdb.collection('posts')
              // .orderBy('dateTime', descending: false)
              .where('useremail',
              isEqualTo: "${loggedInUser.driverEmail}")
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
                            leading: Image.asset("assets/images/avatar.png", width: 60.0,),
                            title: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(document['useremail'], textAlign: TextAlign.left)
                                ),
                                buildPostSection(document['post']),
                              ],
                            ),
                            subtitle:
                                Text(document['dateTime'].toDate().toString()),
                          ),
                        );
                      });
                
              },
            ),
          ),
        ],
      ),
    );    
  }
  Container buildPostSection(String urlPostText) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [          
          buildPostText(urlPostText),
          const SizedBox(
            height: 5,
          ),
          
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
  

  Row buildPostFirstRow(String urlProfilePhoto) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ProfilPage(url: urlProfilePhoto)));
              },  
                child: CircleAvatar(
                  radius: 12,
                  backgroundImage: NetworkImage(urlProfilePhoto),
                ),
              
            ),
            const SizedBox(
              width: 5,
            ),          
          ],
        ),
        const Icon(Icons.more_vert)
      ],
    );
  }

  Stack buildPostText(String urlPostText) {
    return Stack(
      children: [
        SizedBox(
          child: Text(urlPostText),
          height: MediaQuery.of(context).size.width - 285,

          // Positioned(
          //   bottom: 20,
          //   right: 20,
          //   child: Icon(Icons.favorite,
          //       size: 35, color: Colors.white.withOpacity(0.7)),
          // )
        )
      ],
    );
  }
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const DriverLogin()));
  }
}