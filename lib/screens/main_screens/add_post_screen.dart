import 'package:flutter/material.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/utils/colors.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          leading:
              IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {}),
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
              onPressed: () {},
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
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: const NetworkImage(
                      "https://1fid.com/wp-content/uploads/2022/06/cartoon-profile-picture-12-1024x1024.jpg"),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: "Write a caption...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
