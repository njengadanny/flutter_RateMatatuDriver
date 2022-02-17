import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:public_safety_awareness/models/user_data.dart';
import 'package:public_safety_awareness/provider.dart';

import 'provider.dart';

class GetCurrentUser extends StatefulWidget {
  @override
  _GetCurrentUserState createState() => _GetCurrentUserState();
}

class _GetCurrentUserState extends State<GetCurrentUser> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String userProfile = GetCurrentUser().toString();

  void inputData() {
    final User user = _auth.currentUser;
    setState(() {
      userProfile = user.displayName;
    });
  }
final UserData userData =
        UserData(email: '', fname: '', lname: '');

  @override
  Widget build(BuildContext context) {    

    return FutureBuilder(
      // create: (context) => userData.fancyDisplay(),
      future: Provider.of(context).auth.getCurrentUser(),
      builder: (context, snapshot) {
        print('done');
        if (snapshot.connectionState == ConnectionState.done) {
          return displayUserInformation(context, snapshot);
        } else {
          return const Text('error');
        }
      },
    );
  }

  Widget displayUserInformation(context, snapshot) {
    final user = snapshot.data;

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Name: ${user.displayName ?? 'Anonymous'}",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Email: ${user.email ?? 'Anonymous'}",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Created: ${DateFormat('MM/dd/yyyy').format(user.metadata.creationTime)}",
            style: TextStyle(fontSize: 20),
          ),
        ),
        showSignOut(context, user.isAnonymous),
      ],
    );
  }

  Widget showSignOut(context, bool isAnonymous) {
    if (isAnonymous == true) {
      return ElevatedButton(
        child: Text("Sign In To Save Your Data"),
        onPressed: () {
          Navigator.of(context).pushNamed('/convertUser');
        },
      );
    } else {
      return ElevatedButton(
        child: Text("Sign Out"),
        onPressed: () async {
          try {
            await Provider.of(context).auth.signOut();
          } catch (e) {
            print(e);
          }
        },
      );
    }
  }
}
