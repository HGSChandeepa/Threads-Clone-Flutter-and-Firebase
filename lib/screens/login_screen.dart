import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../responsive/responsive_layout_screen.dart';
import '../../screens/register_screen.dart';
import '../../utils/colors.dart';
import '../../widgets/button.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/web_screen_layout.dart';
import '../services/auth_logic.dart';
import '../utils/util_functions.dart';
import '../widgets/text_feild.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //controllers for the text feilds
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoaging = false;

  @override

  //this  dispose methode is for remove the controller data from the memory
  void dispose() {
    super.dispose();
    //dispose the controllers
    _emailController.dispose();
    _passwordController.dispose();
  }

  //auth logic instance
  final AuthMethodes _authMethodes = AuthMethodes();

  //login the user
  void loginUser() async {
    setState(() {
      isLoaging = true;
    });
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    String result = await _authMethodes.loginWithEmailAndPassword(
      email: email,
      password: password,
    );

    //show the snak bar if the user is created or not

    if (result == "email-already-in-use" ||
        result == "weak-password" ||
        result == "invalid-email") {
      showSnakBar(context, result);
    } else if (result == 'success') {
      //here the pushReplacement is used for remove the back button from the screen

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            webSecreenLayout: WebScreenlayout(),
            mobileScreenLayout: MobileScreenLayout(),
          ),
        ),
      );
    }

    setState(() {
      isLoaging = false;
    });

    print("user logged in");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //for the top space
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
                //image for logo
                Image.asset(
                  'assets/threads.png',
                  height: 80,
                ),
                const SizedBox(
                  height: 64,
                ),

                //text feild for email
                TextFeildInput(
                  hintText: 'Enter Email',
                  controller: _emailController,
                  isPassword: false,
                  inputkeyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 30,
                ),
                //text feild for password
                TextFeildInput(
                  hintText: 'Enter Password',
                  controller: _passwordController,
                  isPassword: true,
                  inputkeyboardType: TextInputType.visiblePassword,
                ),
                //button for login
                const SizedBox(
                  height: 30,
                ),
                isLoaging
                    ? const CircularProgressIndicator(
                        color: primaryColor,
                      )
                    : CustomButon(
                        text: 'Log in',
                        onPressed: loginUser,
                      ),
                //button for signup to navigate to signup screen
                const SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign up.',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
