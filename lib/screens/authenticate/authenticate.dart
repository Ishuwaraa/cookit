import 'package:cookit/screens/authenticate/login.dart';
import 'package:cookit/screens/authenticate/register.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  //making sing in the default view
  bool showLogIn = true;

  void toggleView () {
    //if true make it false vice versa
    setState(() => showLogIn = !showLogIn);
  }

  @override
  Widget build(BuildContext context) {
    if(showLogIn) {
      // return SignIn(toggleView : toggleView);
      return Login(onTap: toggleView);
    }
    else {
      // return Register(toggleView : toggleView);
      return Register(onTap: toggleView);
    }
  }
}