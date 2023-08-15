class Post {
  final String uid;
  final String postId;
  final String userName;
  final String description;
  final DateTime datePosted;
  final String postURL;
  final String profilePic;
  final likes;

  Post({
    required this.uid,
    required this.postId,
    required this.userName,
    required this.description,
    required this.datePosted,
    required this.postURL,
    required this.profilePic,
    required this.likes,
  });

  //this methode will convert the user data to json object
  Map<String, dynamic> toJSON() {
    return {
      'uid': uid,
      'postId': postId,
      'userName': userName,
      'description': description,
      'datePosted': datePosted,
      'postURL': postURL,
      'profilePic': profilePic,
      'likes': likes,
    };
  }

  //this methode will convert the json object to user data

  //here factory is  a constructor that returns a new instance of the class
  /*We use the factory keyword to implement constructors that decides whether to return a new instance or an existing instance.*/
  factory Post.fromJSON(Map<String, dynamic> json) {
    return Post(
      uid: json['uid'],
      postId: json['postId'],
      userName: json['userName'],
      description: json['description'],
      datePosted: json['datePosted'],
      postURL: json['postURL'],
      profilePic: json['profilePic'],
      likes: json['likes'],
    );
  }
}
