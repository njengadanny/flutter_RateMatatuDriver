import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_signup/models/post_data.dart';
import 'profil.dart';
import 'login_screen.dart';
import 'models/user_data.dart';
import 'models/post_data.dart';

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  int _selectedItemIndex = 0;
  User? user = FirebaseAuth.instance.currentUser;
  final _auth = FirebaseAuth.instance;
  UserModel loggedInUser = UserModel();
  late final post = TextEditingController();
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
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          leading: null,
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.logout_rounded),
                color: Colors.black,
                onPressed: () {
                  logout(context);
                  //Implement logout functionality
                }),
          ],
          title: const Text('Home',
              style: TextStyle(
                color: Colors.black,
              )),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        drawer: Drawer(
          elevation: 20.0,
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                onDetailsPressed: () {
                  Navigator.pushNamed(context, 'profile');
                },
                accountName: Text("${loggedInUser.firstName} \t\t\tView Profile ",
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
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, 'rate_driver');
                },
                title: const Text("Rate"),
                leading: const Icon(Icons.rate_review),
              ),
              const Divider(
                height: 0.1,
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, 'rate_history');
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
        body: Column(
          children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: TextFormField(
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                controller: post,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () async {
                        submit(
                          post.text,
                        );
                      },
                    ),
                    hintText: 'What is happening?',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                onSaved: (value) {
                  setState(() {
                    post.text = value!;
                  });
                },
              )),
          Flexible(
            child: StreamBuilder<QuerySnapshot>(
              stream: postdb.collection('posts').
              orderBy('dateTime', descending: false)
              .snapshots(),
              builder: (context, snapshot) {
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    child: TextFormField(
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      controller: post,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () async {
                              submit(
                                post.text,
                              );
                            },
                          ),
                          hintText: 'What is happening?',
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          )),
                      onSaved: (value) {
                        setState(() {
                          post.text = value!;
                        });
                      },
                    ));
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
                }
              },
            ),
          ),
        ])
        // body: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children:  [
        //     Padding(
        //       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        //        child: TextFormField(
        //           maxLines: 3,
        //           keyboardType: TextInputType.multiline,
        //           controller: post,
        //           decoration:  InputDecoration(
        //             suffixIcon: IconButton(
        //                 icon: const Icon(Icons.send),
        //                 onPressed: () async {
        //                 submit(
        //                     post.text, );
        //               },
        //                 ),
        //             hintText: 'What is happening?',
        //               border: const OutlineInputBorder(
        //                 borderRadius: BorderRadius.all(Radius.circular(10)),
        //               )
        //           ),
        //           onSaved: (value) {
        //           setState(() {
        //             post.text = value!;
        //           }
        //         );
        //       },
        //     )
        //   ),
        //     // Text(
        //     //   "Stories",
        //     //   style: TextStyle(
        //     //       fontSize: 18,
        //     //       fontWeight: FontWeight.bold,
        //     //       color: Colors.grey[500]),
        //     // ),
        //     // Container(
        //     //   height: 2,
        //     //   color: Colors.grey[300],
        //     //   margin: EdgeInsets.symmetric(horizontal: 30),
        //     // ),
        //     Expanded(
        //       child: ListView(
        //         padding: const EdgeInsets.only(top: 8),
        //         children: [
        //           buildPostSection(
        //               "https://www.kenyans.co.ke/files/styles/article_style/public/images/news/kenyan-matatu-conductors_0.webp?itok=uIuPLUeU",
        //               "https://images.pexels.com/photos/2379005/pexels-photo-2379005.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=100&w=940"),
        //           buildPostSection(
        //               "https://dailyactive.info/wp-content/uploads/2018/12/DmvhULXW4AAp6nK.jpg",
        //               "https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=100&w=640"),
        //           buildPostSection(
        //               "https://miro.medium.com/max/900/0*fQ9XPgNfAXU_XQGh.jpg",
        //               "https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=100&w=640"),
        //         ],
        //       ),
        //     )
        //   ],
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: Container(
        //   height: 60,
        //   child: FittedBox(
        //     child: FloatingActionButton(
        //       onPressed: () {},
        //       child: const Icon(
        //         Icons.add,
        //       ),
        //       backgroundColor: Colors.grey[900],
        //       elevation: 15,
        //     ),
        //   ),
        // ),
        // bottomNavigationBar: Container(
        //   decoration: BoxDecoration(
        //       boxShadow: [
        //         BoxShadow(
        //           color: Colors.grey.withOpacity(0.1),
        //           spreadRadius: 1,
        //         )
        //       ],
        //       color: Colors.grey.withOpacity(0.2),
        //       borderRadius: BorderRadius.circular(15)),
        //   child: Row(
        //     children: [
        //       buildNavBarItem(Icons.home, 0),
        //       buildNavBarItem(Icons.search, 1),
        //       buildNavBarItem(null, -1),
        //       buildNavBarItem(Icons.notifications, 2),
        //       buildNavBarItem(Icons.person, 3),
        //     ],
        //   ),
        // ),
        );
  }

  // Widget buildNavBarItem(IconData? icon, int index) {
  //   return GestureDetector(
  //     onTap: () {
  //       setState(() {
  //         _selectedItemIndex = index;
  //       });
  //     },
  //     child: Container(
  //       width: MediaQuery.of(context).size.width / 5,
  //       height: 45,
  //       child: icon != null
  //           ? Icon(
  //               icon,
  //               size: 25,
  //               color: index == _selectedItemIndex
  //                   ? Colors.black
  //                   : Colors.grey[700],
  //             )
  //           : Container(),
  //     ),
  //   );
  // }

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
                // child: CircleAvatar(
                //       child: ClipRRect(
                //     borderRadius: BorderRadius.circular(30),
                //     child: Image.asset("assets/images/avatar.png"),
                //   ))
                child: CircleAvatar(
                  radius: 12,
                  backgroundImage: NetworkImage(urlProfilePhoto),
                ),
              
            ),
            const SizedBox(
              width: 5,
            ), 
          //   Column(
          //     children: [
          //   Flexible(
          //   child: StreamBuilder<QuerySnapshot>(
          //     stream: postdb.collection('posts').snapshots(),
          //     builder: (context, snapshot) {                
          //       if (!snapshot.hasData) {
          //         return const Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       } else {
          //         return ListView.builder(
          //             itemCount: snapshot.data!.docs.length,
          //             itemBuilder: (context, index) {
          //               DocumentSnapshot document = snapshot.data!.docs[index];

          //               if (document.id == auth.currentUser!.uid) {
          //                 return Container(height: 0);
          //               }

          //               return Card(
          //                 child: ListTile(
          //                   title: Column(
          //                       children: [
          //                         Text(document['useremail'],
          //                               textAlign: TextAlign.center
          //                             ),
          //                       ],
          //                     ),
          //                 ),
          //               );
          //             });
          //       }
          //     },
          //   ),
          // ),
          // ])
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     const Text(
            //       "user1",
            //       style: TextStyle(
            //         fontSize: 18,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //     Text(
            //       "Kenya",
            //       style: TextStyle(
            //           fontSize: 12,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.grey[500]),
            //     ),
            //   ],
            // )
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

  Stack buildPostPicture(String urlPost) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.width - 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(urlPost),
              )),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: Icon(Icons.favorite,
              size: 35, color: Colors.white.withOpacity(0.7)),
        )
      ],
    );
  }

  Container buildStoryAvatar(String url) {
    return Container(
      margin: const EdgeInsets.only(left: 18),
      height: 60,
      width: 60,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.red),
      child: CircleAvatar(
        radius: 18,
        backgroundImage: NetworkImage(url),
      ),
    );
  }

  void submit(
    String post,
  ) async {
    postDetailsToFirestore();
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    // String? id;

    // UserModel userModel = UserModel();
    PostModel postModel = PostModel();
    // DriverModel driverModel = DriverModel();

    // writing all the values
    postModel.useremail = user!.email;
    postModel.post = post.text;
    postModel.dateTime = DateTime.now();

    await firebaseFirestore.collection("posts").doc().set(postModel.toMap());
    Fluttertoast.showToast(msg: "Post Added :) ");

    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => Timeline()), (route) => false);
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
