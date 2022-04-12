import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'home_feed.dart';
import 'timeline.dart';
import 'models/driver_rating.dart';
import 'models/user_data.dart';
import 'models/rating_data.dart';
import 'designs/theme_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({Key? key}) : super(key: key);

  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  double? _ratingValue;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final comment = TextEditingController();
  late var driverID = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final ratedb = FirebaseFirestore.instance;
  String? errorMessage;
  late String searchKey;
  late Stream streamQuery;
  final List<String> routes = [
    'Nairobi -> Nyeri',
    'Nyeri -> Nairobi',
    'Nakuru -> Nairobi',
    'Nairobi -> Nakuru'
  ];

   String? _currentRoute;

  // @override
  // void initState() {
  //   super.initState();
  //   FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(user!.uid)
  //       .get()
  //       .then((value) {
  //     this.loggedInUser = UserModel.fromMap(value.data());
  //     setState(() {});
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'Driver Rating',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 55),
                TextFormField(
                  autofocus: false,
                  controller: driverID,
                  decoration: ThemeHelper().textInputDecoration(
                      'Enter Driver ID: ', 'Enter driver ID'),
                  keyboardType: TextInputType.text,
                  onSaved: (value) {
                    setState(() {
                      driverID = value as TextEditingController;
                      streamQuery = ratedb
                          .collection('drivers')
                          .where('driverID', isGreaterThanOrEqualTo: searchKey)
                          .where('driverID', isLessThan: searchKey + 'z')
                          .snapshots();
                    });
                  },
                ),
                const SizedBox(height: 25),
                DropdownButtonFormField(
                  value: _currentRoute ?? 'Nairobi -> Nyeri',
                    items: routes.map((route) {
                      return DropdownMenuItem(
                        value: route,
                        child: Text('$route route'),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        setState(() => _currentRoute = val as String)
                  ),
                const Text(
                  'How was your trip?',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 25),
                // implement the rating bar
                RatingBar(
                    initialRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    ratingWidget: RatingWidget(
                        full: const Icon(Icons.star, color: Colors.blue),
                        half: const Icon(
                          Icons.star_half,
                          color: Colors.lightBlue,
                        ),
                        empty: const Icon(
                          Icons.star_outline,
                          color: Colors.blue,
                        )),
                    onRatingUpdate: (value) {
                      setState(() {
                        _ratingValue = value;
                      });
                    }),
                const SizedBox(height: 10),
                // Display the rate in number
                Container(
                  width: 150,
                  height: 100,
                  // decoration: const BoxDecoration(
                  //     color: Colors.red, shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: Text(
                    _ratingValue != null ? _ratingValue.toString() : 'Rate it!',
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
                // const SizedBox(height: 20.0),
                TextFormField(
                  autofocus: false,
                  controller: comment,
                  decoration: ThemeHelper().textInputDecoration(
                      'Add a comment(optional)', 'Enter your comment'),
                  keyboardType: TextInputType.text,
                  onSaved: (value) {
                    comment.text = value!;
                  },
                ),
                const SizedBox(height: 25),
                Container(
                  decoration: ThemeHelper().buttonBoxDecoration(context),
                  child: ElevatedButton(
                    style: ThemeHelper().buttonStyle(),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                      child: Text(
                        "Submit".toUpperCase(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      submit(
                          comment.text, driverID.text, _ratingValue.toString());
                      // edit();
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void submit(String comment, String driverID, String _ratingValue) async {
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
    RatingModel ratingModel = RatingModel();
    DriverRatingModel driverratingModel = DriverRatingModel();

    // writing all the values
    ratingModel.useremail = user!.email;
    ratingModel.dateTime = DateTime.now();
    ratingModel.comment = comment.text;
    ratingModel.starRating = _ratingValue.toString();
    ratingModel.driverID = driverID.text;
    ratingModel.route = _currentRoute;
    driverratingModel.driverID = driverID.text;
    driverratingModel.avgRating = _ratingValue.toString();

    await firebaseFirestore
        .collection("ratings")
        .doc()
        .set(ratingModel.toMap());
    Fluttertoast.showToast(msg: "Rating Submitted :) ");

    await firebaseFirestore
        // .collection("ratings")
        .collection("driver_ratings")
        .doc()
        .set(driverratingModel.toMap());

    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => HomeFeed()), (route) => false);
  }
}
