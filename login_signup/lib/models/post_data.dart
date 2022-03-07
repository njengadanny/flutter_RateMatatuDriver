class PostModel {
  String? postid;
  String? post;

  PostModel({this.postid, this.post});

  // receiving data from server
  factory PostModel.fromMap(map) {
    return PostModel(
      postid: map['post_id'],
      post: map['post'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'post_id': postid,
      'post': post,
    };
  }
}