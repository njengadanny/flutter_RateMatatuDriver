import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditUser extends StatefulWidget {
  final String uid;

  EditUser({Key? key, required this.uid}) : super(key: key);
  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController secondNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: firstNameController,
            decoration: const InputDecoration(hintText: "firstName..."),
          ),
          TextFormField(
            controller: secondNameController,
            decoration: const InputDecoration(hintText: "secondName..."),
          ),
          GestureDetector(
            onTap: () async {
              String newfirstName = firstNameController.text.trim();
              String newsecondName = secondNameController.text.trim();

              FirebaseFirestore.instance
                  .collection('users')
                  .doc(widget.uid)
                  .update({
                'firstName': newfirstName,
                'secondName': newsecondName,
              });
            },
            child: Container(
              height: 50,
              width: 100,
              color: Colors.blue,
              child: const Center(
                child: Text(
                  "UPDATE DATA",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
