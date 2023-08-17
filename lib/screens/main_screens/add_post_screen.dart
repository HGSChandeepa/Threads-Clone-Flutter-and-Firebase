import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../services/firestore_methodes.dart';
import '../../utils/colors.dart';
import '../../utils/util_functions.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../../providers/user_provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();

  bool _isLoading = false;
  //methode to opea a dialog to choose between camera and gallery
  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text("create a Post"),
            children: [
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: const Text("Take a  photo"),
                onPressed: () async {
                  //remove the Dialogbox
                  Navigator.of(context).pop();
                  //pick the image and store the image
                  Uint8List file = await pickImage(ImageSource.camera);

                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: const Text("Choose from Gallery"),
                onPressed: () async {
                  //remove the Dialogbox
                  Navigator.of(context).pop();
                  //pick the image and store the image
                  Uint8List file = await pickImage(ImageSource.gallery);

                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: const Text("Cancel"),
                onPressed: () {
                  //remove the Dialogbox
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void postImage({
    required String uid,
    required String userName,
    required String profileImage,
  }) async {
    setState(() {
      _isLoading = true;
    });
    String res = "some error occcured";
    //create a new colection called posts and store the posts
    //also store the file in to the storage
    try {
      res = await FirestoreMethodes().uploadPoast(
          _file!, _descriptionController.text, uid, userName, profileImage);

      //if the res is success
      if (res == "success") {
        setState(() {
          _isLoading = false;
        });

        showSnakBar(context, "posted!");
        //this will clear the image and dirrect us to the main page
        clearImage();
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnakBar(context, res);
      }
    } catch (error) {
      showSnakBar(context, error.toString());
    }
  }

  ///clear image
  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //get the user from the state
    final User user = Provider.of<UserProvider>(context).getUser;

    return _file == null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: IconButton(
                  onPressed: () => _selectImage(context),
                  icon: const Icon(Icons.upload),
                ),
              ),
              const Text("Select an image to post"),
            ],
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back), onPressed: clearImage),
              title: const Text(
                "Create New Post",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: () => postImage(
                    profileImage: user.profilePic,
                    uid: user.uid,
                    userName: user.userName,
                  ),
                  child: const Text(
                    "Post",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //show the progress bar if the image is uploading
                  _isLoading
                      ? const LinearProgressIndicator()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(),
                        ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(user.profilePic),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: TextField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            hintText: "Write a caption...",
                            border: InputBorder.none,
                          ),
                          maxLines: 8,
                        ),
                      ),
                      Divider(
                        color: secondaryColor,
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: MemoryImage(_file!),
                            fit: BoxFit.cover,
                            alignment: FractionalOffset.topCenter,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}
