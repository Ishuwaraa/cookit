import 'package:cookit/components/loading.dart';
import 'package:cookit/components/submit_button.dart';
import 'package:cookit/components/styled_textfield.dart';
import 'package:cookit/screens/authenticate/forgot_password.dart';
import 'package:cookit/services/auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final Function()? onTap;
  // ignore: prefer_const_constructors_in_immutables
  Login({super.key, required this.onTap});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final AuthService _auth = AuthService();
  bool loading = false;

  //text editing controllers
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void checkEmailPass() async {
    if(_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty){
      setState(() => loading = true);
      dynamic result = await _auth.signinWithEmailAndPassword(_emailController.text.trim(), _passwordController.text.trim());
      // dynamic result = await Provider.of<AuthService>(context, listen: false).signinWithEmailAndPassword(_emailController.text.trim(), _passwordController.text.trim());

      if(result == null){
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Could not sign in with those credentials.'),
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xFF86BF3E),
        ));
      }
      // print('email: ${emailController.text}, pass: ${passwordController.text}');
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Email or password is empty.'),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFF86BF3E),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading? const Loading() : Scaffold(
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
                    controller: _emailController,
                    hintText: 'Email',
                    obscureText: false),
                const SizedBox(height: 10),

                //password textfield
                StyledTextfield(
                    controller: _passwordController,
                    hintText: 'Password',
                    obscureText: true),
                const SizedBox(height: 10),

                //forget password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPassword()));
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
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
