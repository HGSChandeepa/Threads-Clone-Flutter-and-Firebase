class User {
  final String uid;
  final String email;
  final String userName;
  final String bio;
  final String profilePic;
  final List followers;
  final List following;

  User({
    required this.uid,
    required this.email,
    required this.userName,
    required this.bio,
    required this.profilePic,
    required this.followers,
    required this.following,
  });

  //this methode will convert the user data to json object
  Map<String, dynamic> toJSON() {
    return {
      'uid': uid,
      'email': email,
      'userName': userName,
      'bio': bio,
      'profilePic': profilePic,
      'followers': followers,
      'following': following,
    };
  }

  //this methode will convert the json object to user data

  //here factory is  a constructor that returns a new instance of the class
  /*We use the factory keyword to implement constructors that decides whether to return a new instance or an existing instance.*/
  factory User.fromJSON(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      email: json['email'],
      userName: json['userName'],
      bio: json['bio'],
      profilePic: json['profilePic'],
      followers: json['followers'],
      following: json['following'],
    );
  }
}
