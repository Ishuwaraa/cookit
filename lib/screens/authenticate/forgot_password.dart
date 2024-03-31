import 'package:cookit/Components/styled_textfield.dart';
import 'package:cookit/Components/submit_button.dart';
import 'package:cookit/components/loading.dart';
import 'package:cookit/services/auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final AuthService _auth = AuthService();
  bool loading = false;
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void resetPassword() async {
    if(_emailController.text.isNotEmpty){
      setState(() => loading = true);
      bool result = await _auth.forgotPassword(_emailController.text.trim());

      if(result){
        setState(() => loading = false);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Password reset email sent.'),
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xFF86BF3E),
        ));
      }else{
        //doesnt work cuz firebase doesnt throw an error if the email not registered
        setState(() => loading = false);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please enter a valid email.'),
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xFF86BF3E)
        ));
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter a valid email.'),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFF86BF3E),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading? const Loading() : Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Forgot Your Password?',
                style: TextStyle(
                  fontSize: 36,
                  color: Color(0xFF86BF3E),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Don\'t worry! We\'ve got you covered.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 40),
              StyledTextfield(
                controller: _emailController,
                hintText: 'Enter your email',
                obscureText: false,
              ),
              const SizedBox(height: 25),
              SubmitButton(
                onTap: resetPassword,
                text: 'Reset Password',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
