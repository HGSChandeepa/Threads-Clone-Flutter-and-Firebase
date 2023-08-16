import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: SvgPicture.asset(
            'assets/ic_instagram.svg',
            // ignore: deprecated_member_use
            color: primaryColor,
            height: 32,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.messenger_outline),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              PostCard(),
              PostCard(),
              PostCard(),
            ],
          ),
        ));
  }
}
