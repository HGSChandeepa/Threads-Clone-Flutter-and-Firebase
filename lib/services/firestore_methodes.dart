import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../../services/storage_methodes.dart';
import 'package:uuid/uuid.dart';

import '../models/post.dart';

class FirestoreMethodes {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //uploadPost
  Future<String> uploadPoast(
    Uint8List file,
    String description,
    String uid,
    String userName,
    String profileImage,
  ) async {
    String res = "some error occured";
    try {
      //first store the image in the firebase storage and get the URL of the image

      String photoURL =
          await StorageMethodes().uploadImage("posts", true, file);

      //crete a post id here v4 is genarated from a random number
      String postId = const Uuid().v4();
      //create the post
      Post post = Post(
        description: description,
        uid: uid,
        userName: userName,
        postId: postId,
        datePosted: DateTime.now(),
        postURL: photoURL,
        profilePic: profileImage,
        likes: [],
      );

      //upload to the firabase
      _firestore.collection('posts').doc(postId).set(post.toJSON());

      res = "success";
    } catch (error) {
      res = error.toString();
    }

    return res;
  }

  //Like posts
  Future<void> likePosts(
      {required String postID,
      required String uid,
      required List likes}) async {
    try {
      //if the liked user is already liked then remove the userid from the liked array
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postID).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postID).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
  }

  //delete post
  Future<void> deletePost({required String postId}) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (error) {
      print(error.toString());
    }
  }

  //follow
  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      if (kDebugMode) print(e.toString());
    }
  }
}
