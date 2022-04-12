class RatingModel {
  DateTime? dateTime;
  String? useremail;
  String? starRating;
  String? comment;
  String? driverID;
  String? route;

  RatingModel(
      {this.dateTime,
      this.useremail,
      this.starRating,
      this.comment,
      this.driverID,
      this.route});

  // receiving data from server
  factory RatingModel.fromMap(map) {
    return RatingModel(
      dateTime: map['dateTime'],
      useremail: map['email'],
      starRating: map['starRating'],
      comment: map['comment'],
      driverID: map['driverID'],
      route: map['route'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime,
      'useremail': useremail,
      'starRating': starRating,
      'comment': comment,
      'driverID': driverID,
      'route': route,
    };
  }
}
