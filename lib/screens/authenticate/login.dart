import 'package:cookit/components/my_button.dart';
import 'package:cookit/components/my_textfield.dart';
import 'package:cookit/components/square_tile.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  // ignore: prefer_const_constructors_in_immutables
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                        width:
                            10), // Adjust the spacing between the icon and the image
                    Image.asset(
                      'lib/images/Subject 16.png',
                      width: 200, // Adjust the width of the image as needed
                      height: 200, // Adjust the height of the image as needed
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                //email textfield
                MytextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false),
                const SizedBox(height: 10),

                //password textfield
                MytextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true),
                const SizedBox(height: 10),

                //forget password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                //sign in button
                const MyButton(
                  text: "Sign In",
                  onTap: null,
                ),
                const SizedBox(height: 50),

                //or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or Continue With',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                //google or apple id

                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //google button

                    SquareTile(imagepath: 'lib/images/google.png'),
                    SizedBox(width: 25),

                    //apple button
                    SquareTile(imagepath: 'lib/images/apple.png'),
                  ],
                ),

                const SizedBox(height: 50),
                //not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                          color: Color(0xFF86BF3E),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
