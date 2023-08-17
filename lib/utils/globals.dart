import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/main_screens/feed_screen.dart';
import '../../screens/main_screens/add_post_screen.dart';
import '../screens/main_screens/search_screen.dart';
import '../screens/profile_screen.dart';

List<Widget> homeScreenLayouts = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Text("Favorite"),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
