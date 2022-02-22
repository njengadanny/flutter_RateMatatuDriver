
class RatingModel {
  String? uid;
  String? email;
  String? starRating;
  String? comment;
  String? driverID;


  RatingModel({this.uid, this.email, this.starRating, this.comment, this.driverID});

  // receiving data from server
  factory RatingModel.fromMap(map) {
    return RatingModel(
      uid: map['uid'],
      email: map['email'],
      starRating: map['starRating'],
      comment: map['comment'],
      driverID: map['driverID'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'starRating': starRating,
      'comment': comment,
      'driverID': driverID,
    };
  }
}
