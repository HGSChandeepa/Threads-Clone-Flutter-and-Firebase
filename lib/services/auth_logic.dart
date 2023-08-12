import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/services/storage_methodes.dart';

class AuthMethodes {
  //firebase auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //register new user
  Future<String> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String userName,
    required String bio,
    required Uint8List profilePic,
  }) async {
    String res = "An error occured";

    try {
      //if the inputs are not empty
      if (userName.isNotEmpty &&
          password.isNotEmpty &&
          userName.isNotEmpty &&
          bio.isNotEmpty &&
          profilePic.isNotEmpty) {
        //create a new user with email and password
        final UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);

        //upload the profile image to the firebase storage
        String photoURL = await StorageMethodes()
            .uploadImage("ProfileImages", false, profilePic);

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
            'profilePic': photoURL,
          });

          res = "User created successfully";
        }
      }
    }

    //catch the errors extra error handling
    on FirebaseAuthException catch (error) {
      if (error.code == "invalid-email") {
        res = "Invalid email";
      } else if (error.code == "weak-password") {
        res = "Weak password";
      } else if (error.code == "email-already-in-use") {
        res = "Email already in use";
      }
    } catch (error) {
      res = error.toString();
    }

    return res;
  }

  //login user
  Future<String> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    String res = "An error occured";

    try {
      //if the inputs are not empty
      if (email.isNotEmpty && password.isNotEmpty) {
        //login the user with email and password
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        res = "User logged in successfully";
      } else {
        res = "Please enter email and password";
      }
    }

    //catch the errors extra error handling
    on FirebaseAuthException catch (error) {
      if (error.code == "invalid-email") {
        res = "Invalid email";
      } else if (error.code == "weak-password") {
        res = "Weak password";
      } else if (error.code == "email-already-in-use") {
        res = "Email already in use";
      }
    } catch (error) {
      res = error.toString();
    }

    return res;
  }
}
