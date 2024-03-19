import 'package:cookit/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_firebase/models/myUser.dart';
// import 'package:flutter_firebase/screens/authenticate/authenticate.dart';
// import 'package:flutter_firebase/screens/home/home.dart';
// import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    
    //everytime a user logs in we are getting a user object from the stream and storing it in this userR variable
    //everytime a user logs out userR will be set to null
    // final useR = Provider.of<MyUser?>(context);
    // print(useR);

    //return either home or authenticate widget
    // if(useR == null) return Authenticate();
    // else return Home();

    return const Authenticate();
  }
}