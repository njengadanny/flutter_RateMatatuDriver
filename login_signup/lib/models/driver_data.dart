class DriverModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? avgRating;

  DriverModel({this.uid, this.email, this.firstName, this.secondName, this.avgRating});

  // receiving data from server
  factory DriverModel.fromMap(map) {
    return DriverModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      avgRating: map['avgRating'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'avgRating': avgRating,
    };
  }
}
