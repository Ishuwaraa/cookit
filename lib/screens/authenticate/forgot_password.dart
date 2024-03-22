import 'package:cookit/Components/styled_textfield.dart';
import 'package:cookit/Components/submit_button.dart';
import 'package:cookit/components/appbar_title.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Forgot Password?',
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
              const StyledTextfield(
                controller: null,
                hintText: 'Enter your email',
                obscureText: false,
              ),
              const SizedBox(height: 25),
              SubmitButton(
                onTap: () {},
                text: 'Reset Password',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
