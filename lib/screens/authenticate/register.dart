import 'package:cookit/components/submit_button.dart';
import 'package:cookit/components/styled_textfield.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function()? onTap;
  const Register({super.key, required this.onTap});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //text editing controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  void registerUser(){
    if(nameController.text.isNotEmpty && emailController.text.isNotEmpty && passwordController.text.isNotEmpty && confirmpasswordController.text.isNotEmpty){
      if(passwordController.text == confirmpasswordController.text){
        print('user registered successfully');
      }else{
        print('Passwords do not match');
      }
    }else{
      print('All field should be filled');
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
                const SizedBox(height: 25),

                //Let\'s create an account for you!
                Text(
                  'Let\'s create an account for you!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),
                //Name textfield
                StyledTextfield(
                    controller: nameController,
                    hintText: 'Full name',
                    obscureText: false),
                const SizedBox(height: 10),

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

                //Confirm password textfield
                StyledTextfield(
                    controller: confirmpasswordController,
                    hintText: 'Confirm password',
                    obscureText: true),

                const SizedBox(height: 25),
                //sign in button
                SubmitButton(
                  text: "Sign Up",
                  onTap: registerUser,
                ),
                
                const SizedBox(height: 50),
                //not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
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
