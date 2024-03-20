import 'package:cookit/components/submit_button.dart';
import 'package:cookit/components/styled_textfield.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final Function()? onTap;
  // ignore: prefer_const_constructors_in_immutables
  Login({super.key, required this.onTap});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void checkEmailPass(){
    // if(emailController.is )
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
      print('email: ${emailController.text}, pass: ${passwordController.text}');
    }else{
      print('email or password is empty');
    }
  }

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
                      'assets/cookit-logo.png',
                      width: 200, // Adjust the width of the image as needed
                      height: 200, // Adjust the height of the image as needed
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                //email textfield
                StyledTextfield(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false),
                const SizedBox(height: 10),

                //password textfield
                StyledTextfield(
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
                SubmitButton(
                  text: "Sign In",
                  onTap: checkEmailPass,
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
