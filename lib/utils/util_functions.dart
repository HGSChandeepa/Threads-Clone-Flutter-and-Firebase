import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//this methode is for pick the image from the gallery or camera

pickImage(ImageSource source) async {
  //create an instance of image picker
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);

  //check there is a image
  if (_file != null) {
    //return the image
    return await _file.readAsBytes();
  }
  print("no image selected");
}

//snakbar

showSnakBar(BuildContext context, String res) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(res),
    ),
  );
}
