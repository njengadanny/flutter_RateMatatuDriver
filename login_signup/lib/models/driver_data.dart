class DriverModel {
  String? uid;
  String? driverID;
  String? email;
  String? driverfirstName;
  String? driversecondName;
  String? avgRating;

  DriverModel({this.uid, this.driverID, this.email, this.driverfirstName, this.driversecondName, this.avgRating});

  // receiving data from server
  factory DriverModel.fromMap(map) {
    return DriverModel(
      uid: map['uid'],
      email: map['email'],
      driverfirstName: map['firstName'],
      driversecondName: map['secondName'],
      avgRating: map['avgRating'],
      driverID: map['driverID'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'driverID': driverID,
      'email': email,
      'firstName': driverfirstName,
      'secondName': driversecondName,
      'avgRating': avgRating,
    };
  }
}
