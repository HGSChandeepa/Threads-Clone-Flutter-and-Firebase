import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/globals.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController _pageController;

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  //?initial methode for getting the user name
  // String userName = "";

  // void getUserName() async {
  //   //get the uid of the current user
  //   FirebaseAuth _auth = FirebaseAuth.instance;
  //   String uid = await _auth.currentUser!.uid;

  //   //get the user name from the firestore
  //   DocumentSnapshot snapshot =
  //       await FirebaseFirestore.instance.collection('users').doc(uid).get();

  //   setState(() {
  //     userName = snapshot['userName'];
  //   });
  // }

  //?new methode for getting the user name

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    //get the user name
    // user_model.User user = Provider.of<UserProvider>(context).getUser!;
    return Scaffold(
      body: PageView(
        children: homeScreenLayouts,
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _page == 0 ? primaryColor : secondaryColor,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: _page == 1 ? primaryColor : secondaryColor,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle,
              color: _page == 2 ? primaryColor : secondaryColor,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border,
              color: _page == 3 ? primaryColor : secondaryColor,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _page == 4 ? primaryColor : secondaryColor,
            ),
            label: "",
          ),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }
}
