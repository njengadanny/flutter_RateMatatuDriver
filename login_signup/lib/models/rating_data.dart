import 'user_data.dart';
import 'driver_data.dart';

class RatingModel {
  String? uid;
  String? email;
  String? starRating;

  RatingModel({this.uid, this.email, this.starRating});

  // receiving data from server
  factory RatingModel.fromMap(map) {
    return RatingModel(
      uid: map['uid'],
      email: map['email'],
      starRating: map['starRating'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'starRating': starRating,
    };
  }
}