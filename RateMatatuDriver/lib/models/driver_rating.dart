class DriverRatingModel {
  String? driverID;
  String? avgRating;

  DriverRatingModel({ this.driverID, this.avgRating,});

  // receiving data from server
  factory DriverRatingModel.fromMap(map) {
    return DriverRatingModel(
      avgRating: map['avgRating'],
      driverID: map['driverID'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'driverID': driverID,
      'avgRating': avgRating,
    };
  }
}
