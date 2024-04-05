import 'package:cookit/components/bottom_navbar.dart';
import 'package:cookit/models/user_model.dart';
import 'package:cookit/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<UserModel?>(context);

    if(user == null) {
      return Authenticate();
    }else {
      return BottomNavBar();
    }

    // return StreamBuilder<UserModel?>(
    //   stream: Provider.of<AuthService>(context).currUser,
    //   builder: (context, snapshot) {
    //     if(snapshot.connectionState == ConnectionState.waiting){
    //       return Loading();
    //     }else if (snapshot.hasData){
    //       return BottomNavBar();
    //     }else{
    //       return Authenticate();
    //     }
    //   },
    // );
  }
}