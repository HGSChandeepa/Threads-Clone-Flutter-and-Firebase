import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/services/auth_logic.dart';
import 'package:instagram_clone/services/firestore_methodes.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/util_functions.dart';
import '../widgets/follow_button.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;

  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int postLength = 0;
  int followersLength = 0;
  int followingLength = 0;
  bool _isLoadnig = false;

  //to check if we are following the user or not
  bool isFollowing = false;
  //function to create the coloum
  Column userStatsColoum({required int number, required String lable}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          number.toString(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
        ),
        Text(
          lable,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
        ),
      ],
    );
  }

  getUserData() async {
    setState(() {
      _isLoadnig = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      userData = userSnap.data()!;

      //getthe posts links
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: widget.uid)
          .get();

      postLength = postSnap.docs.length;
      followersLength = userData['followers'].length;
      followingLength = userData['following'].length;
      //check if we are following the user or not
      isFollowing = userData['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      //update the ui this is a must so we can see the changes
      // telling Flutter that the internal state of the widget has changed and that the UI should be rebuilt to reflect this change.
      setState(() {});
      setState(() {
        _isLoadnig = false;
      });
    } catch (error) {
      showSnakBar(context, error.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Widget build(BuildContext context) {
    //take the user from userprovider

    return _isLoadnig
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              title: const Text(
                "Profile",
                style: TextStyle(
                    color: mainYellowColor,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: false,
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.yellowAccent,
                              backgroundImage:
                                  NetworkImage(userData['profilePic']),
                              radius: 40,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    userStatsColoum(
                                        number: postLength, lable: "Posts"),
                                    userStatsColoum(
                                        number: followersLength,
                                        lable: "Followers"),
                                    userStatsColoum(
                                        number: followingLength,
                                        lable: "Following"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    FirebaseAuth.instance.currentUser!.uid ==
                                            widget.uid
                                        ? FollowButton(
                                            text: "Sign Out",
                                            backgroundColor:
                                                mobileBackgroundColor,
                                            textColor: primaryColor,
                                            borderColor: mainYellowColor,
                                            function: () async {
                                              await AuthMethodes().signOut();
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginScreen(),
                                              ));
                                            },
                                          )
                                        : isFollowing
                                            ? FollowButton(
                                                backgroundColor:
                                                    mobileBackgroundColor,
                                                borderColor: mainYellowColor,
                                                text: "UnFollow",
                                                textColor: primaryColor,
                                                function: () async {
                                                  await FirestoreMethodes()
                                                      .followUser(
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid,
                                                          userData['uid']);

                                                  setState(() {
                                                    isFollowing = false;
                                                    followersLength--;
                                                  });
                                                },
                                              )
                                            : FollowButton(
                                                backgroundColor:
                                                    mobileBackgroundColor,
                                                borderColor: mainYellowColor,
                                                text: "Follow",
                                                textColor: primaryColor,
                                                function: () async {
                                                  await FirestoreMethodes()
                                                      .followUser(
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid,
                                                          userData['uid']);

                                                  setState(() {
                                                    isFollowing = true;
                                                    followersLength++;
                                                  });
                                                },
                                              )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          userData['userName'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          userData['bio'],
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              color: secondaryColor),
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(
                  color: secondaryColor,
                ),

                //?posts
                FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('posts')
                      .where('uid', isEqualTo: widget.uid)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 1.5,
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot snap = snapshot.data!.docs[index];

                        return Container(
                          child: Image(
                            image: NetworkImage(
                              snap['postURL'],
                            ),
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  },
                )
              ],
            ),
          );
  }
}
