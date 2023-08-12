import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthMethodes {
  //firebase auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //register new user
  Future registerWithEmailAndPassword({
    required String email,
    required String password,
    required String userName,
    required String bio,
    // required Uint8List profilePic,
  }) async {
    String res = "An error occured";

    try {
      //if the inputs are not empty
      if (userName.isNotEmpty &&
          password.isNotEmpty &&
          userName.isNotEmpty &&
          bio.isNotEmpty) {
        //create a new user with email and password
        final UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);

        //if the user is created store the user data in the firestore
        if (userCredential.user != null) {
          //store the user data in the firestore
          await _firestore
              .collection('users')
              .doc(userCredential.user!.uid)
              .set({
            'uid': userCredential.user!.uid,
            'email': email,
            'userName': userName,
            'bio': bio,
            'followers': [],
            'following': [],
          });

          res = "User created successfully";
        }
      }
    } catch (error) {
      res = error.toString();
    }

    return res;
  }
}
