class PostModel {
  String? useremail;
  String? post;
  DateTime? dateTime;


  PostModel({this.useremail, this.post, this.dateTime});

  // receiving data from server
  factory PostModel.fromMap(map) {
    return PostModel(
      useremail: map['email'],
      post: map['post'],
      dateTime: map['dateTime'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'useremail': useremail,
      'post': post,
      'dateTime': dateTime,
    };
  }
}