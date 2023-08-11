import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utils/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //check this is weather web or mobile and add the firebaseinit
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAfPE4hRgclcg6bz4TKLJJiZaJnVa0u_ko",
        appId: "1:49499841907:web:c158da108a3255ac3fd106",
        messagingSenderId: "49499841907",
        projectId: "instagram-clone-49fc2",
        storageBucket: "instagram-clone-49fc2.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      // home: const ResponsiveLayout(
      //   webSecreenLayout: WebScreenlayout(),
      //   mobileScreenLayout: MobileScreenLayout(),
      // ),
      home: LoginScreen(),
    );
  }
}
