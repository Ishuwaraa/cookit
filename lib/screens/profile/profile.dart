import 'package:cookit/screens/profile/profile_settings.dart';
import 'package:cookit/services/auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COOKIT'),
      ),
      body: Column(
        children: [
          const Text('Hello world'),
          ElevatedButton(
            onPressed: () async {
              await _auth.signOutUser();
            }, 
            child: const Text('Log out')),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileSettings()));
            },
            child: const Text('Settings page'))
        ],
      ),
    );
  }
}