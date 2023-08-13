import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:instagram_clone/models/user.dart' as user_model;

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  //?initial methode for getting the user name
  // String userName = "";

  // void getUserName() async {
  //   //get the uid of the current user
  //   FirebaseAuth _auth = FirebaseAuth.instance;
  //   String uid = await _auth.currentUser!.uid;

  //   //get the user name from the firestore
  //   DocumentSnapshot snapshot =
  //       await FirebaseFirestore.instance.collection('users').doc(uid).get();

  //   setState(() {
  //     userName = snapshot['userName'];
  //   });
  // }

  //?new methode for getting the user name

  @override
  Widget build(BuildContext context) {
    //get the user name
    // user_model.User user = Provider.of<UserProvider>(context).getUser!;
    return Scaffold(
      body: Center(
        child: Text("this is mobile screen"),
      ),
    );
  }
}
