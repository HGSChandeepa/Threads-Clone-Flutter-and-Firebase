import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/main_screens/feed_screen.dart';
import '../../screens/main_screens/add_post_screen.dart';

const homeScreenLayouts = [
  FeedScreen(),
  Text("Search"),
  AddPostScreen(),
  Text("Favorite"),
  Text("Profile"),
];
