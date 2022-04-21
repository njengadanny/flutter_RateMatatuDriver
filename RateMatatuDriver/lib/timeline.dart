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
