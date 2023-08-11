import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/dimentions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webSecreenLayout;
  final Widget mobileScreenLayout;

  //this is the constructor
  const ResponsiveLayout(
      {Key? key,
      required this.webSecreenLayout,
      required this.mobileScreenLayout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webSecreenSize) {
          //display the web screen
          return webSecreenLayout;
        } else {
          //display the mobiel screen
          return mobileScreenLayout;
        }
      },
    );
  }
}
