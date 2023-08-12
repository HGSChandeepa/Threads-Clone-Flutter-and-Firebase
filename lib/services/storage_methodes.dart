import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethodes {
  //firebase storage  instance
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //store the images in the firebase storage
  //here we can store the profile images and post images from a single methode

  Future<String> uploadImage(
      String floderName, bool isPost, Uint8List file) async {
    //create a reference for the image here we also select the correct folder
    Reference ref =
        _storage.ref().child(floderName).child(_auth.currentUser!.uid);
    //upload the image to the firebase storage
    UploadTask uploadTask = ref.putData(file);
    //get the download url of the image from the snapshot
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    //return the download url
    return downloadUrl;
  }
}
