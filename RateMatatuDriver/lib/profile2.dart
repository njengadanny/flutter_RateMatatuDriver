import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_signup/profil.dart';
import 'login_screen.dart';
import 'models/user_data.dart';
import 'update_profile.dart';


class ProfilePage extends StatefulWidget {
   State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final postdb = FirebaseFirestore.instance;
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
                      MaterialPageRoute(builder: (context) => UpdateProfile()));
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
                  "${loggedInUser.firstName}",
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
                  '${loggedInUser.secondName}',
                  style: GoogleFonts.lato(
                      color: Colors.grey[600],
                      fontSize: 14,
                      letterSpacing: 1,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
          // const SizedBox(
          //   height: 30,
          // ),
          // Row(
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.only(left: 24.0),
          //       child: Text(
          //         'Email ',
          //         style: GoogleFonts.lato(
          //             color: Colors.grey[900],
          //             fontSize: 16,
          //             letterSpacing: 0,
          //             fontWeight: FontWeight.bold),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(left: 14.0),
          //       child: Text(
          //         '${loggedInUser.email}',
          //         style: GoogleFonts.lato(
          //             color: Colors.grey[600],
          //             fontSize: 14,
          //             letterSpacing: 1,
          //             fontWeight: FontWeight.normal),
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(
          //   height: 30,
          // ),
          // Row(
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.only(left: 24.0),
          //       child: Text(
          //         'Location ',
          //         style: GoogleFonts.lato(
          //             color: Colors.grey[900],
          //             fontSize: 16,
          //             letterSpacing: 0,
          //             fontWeight: FontWeight.bold),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(left: 14.0),
          //       child: Text(
          //         '  Delhi, India',
          //         style: GoogleFonts.lato(
          //             color: Colors.grey[600],
          //             fontSize: 14,
          //             letterSpacing: 1,
          //             fontWeight: FontWeight.normal),
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          // const Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 22.0),
          //   child: Divider(),
          // ),
          // const SizedBox(
          //   height: 30,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     const Padding(
          //       padding: EdgeInsets.only(left: 24.0),
          //       child: Icon(Icons.person),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(left: 8.0),
          //       child: Text(
          //         'Private Information',
          //         style: GoogleFonts.lato(
          //             color: Colors.grey[700],
          //             fontSize: 17,
          //             letterSpacing: 0.5,
          //             fontWeight: FontWeight.bold),
          //       ),
          //     ),
          //   ],
          // ),
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
                  '${loggedInUser.email}',
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
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.only(left: 54.0),
          //       child: Icon(Icons.phone, color: Colors.grey[500]),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(left: 8.0),
          //       child: Text(
          //         '+91 - 9560419114',
          //         style: GoogleFonts.lato(
          //             color: Colors.grey[700],
          //             fontSize: 14,
          //             letterSpacing: 1,
          //             fontWeight: FontWeight.normal),
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.only(left: 54.0),
          //       child: Icon(Icons.home_outlined, color: Colors.grey[500]),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(left: 8.0),
          //       child: Text(
          //         'RZ- 5167, Hari Nagar, New Delhi',
          //         style: GoogleFonts.lato(
          //             color: Colors.grey[700],
          //             fontSize: 14,
          //             letterSpacing: 1,
          //             fontWeight: FontWeight.normal),
          //       ),
          //     ),
          //   ],
          // ),
          Flexible(
            child: StreamBuilder<QuerySnapshot>(
              stream: postdb.collection('posts')
              // .orderBy('dateTime', descending: false)
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
                            leading: Image.asset("assets/images/avatar.png", width: 60.0,),
                            title: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(document['useremail'], textAlign: TextAlign.left)
                                ),
                                buildPostSection(document['post']),
                                // "https://images.pexels.com/photos/2379005/pexels-photo-2379005.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=100&w=940"),
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
          // buildPostFirstRow(urlProfilePhoto),
          // const SizedBox(
          //   height: 10,
          // ),
          // buildPostPicture(urlPost),
          // const SizedBox(
          //   height: 5,
          // ),
          buildPostText(urlPostText),
          const SizedBox(
            height: 5,
          ),
          // Text(
          //   "963 likes",
          //   style: TextStyle(
          //       fontSize: 17,
          //       fontWeight: FontWeight.bold,
          //       color: Colors.grey[800]),
          // ),
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
        )
      ],
    );
  }
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}