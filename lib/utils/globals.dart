import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/main_screens/feed_screen.dart';
import '../../screens/main_screens/add_post_screen.dart';
import '../screens/main_screens/search_screen.dart';
import '../screens/profile_screen.dart';

const homeScreenLayouts = [
  FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  Text("Favorite"),
  ProfileScreen(),
];
