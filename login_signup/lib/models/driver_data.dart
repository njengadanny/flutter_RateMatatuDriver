class DriverModel {
  String? uid;
  String? driverID;
  String? driverEmail;
  String? driverfirstName;
  String? driversecondName;

  DriverModel({this.uid, this.driverID, this.driverEmail,  this.driverfirstName, this.driversecondName,});

  // receiving data from server
  factory DriverModel.fromMap(map) {
    return DriverModel(
      uid: map['uid'],
      driverEmail: map['driverEmail'],
      driverfirstName: map['firstName'],
      driversecondName: map['secondName'],
      driverID: map['driverID'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'driverID': driverID,
      'driverEmail': driverEmail,
      'firstName': driverfirstName,
      'secondName': driversecondName,
    };
  }
}
