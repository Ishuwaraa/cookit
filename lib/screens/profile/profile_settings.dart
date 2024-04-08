import 'package:cookit/Screens/profile/feedback.dart';
import 'package:cookit/Screens/profile/privacy.dart';
import 'package:cookit/components/appbar_title.dart';
import 'package:cookit/screens/authenticate/authenticate.dart';
import 'package:cookit/screens/authenticate/login.dart';
import 'package:cookit/services/auth.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: const AppbarTitle(title: 'Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.feedback),
            title: const Text('Feedback'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FeedbackPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Privacy Policy'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
              );
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.logout),
          //   title: const Text('Logout'),
          //   onTap: () {
          //     showDialog(
          //       context: context,
          //       builder: (context) => AlertDialog(
          //         title: const Text('Logout'),
          //         content: const Text('Are you sure you want to logout?'),
          //         actions: [
          //           TextButton(
          //             onPressed: () async {
          //               await _auth.signOutUser();
          //               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Authenticate()), (route) => false);
          //             },
          //             style: ButtonStyle(
          //               foregroundColor:
          //                   MaterialStateProperty.all<Color>(Colors.red),
          //             ),
          //             child: const Text('Logout'),
          //           ),
          //           TextButton(
          //             onPressed: () {
          //               Navigator.pop(context);
          //             },
          //             style: ButtonStyle(
          //               foregroundColor:
          //                   MaterialStateProperty.all<Color>(Colors.grey),
          //             ),
          //             child: const Text('Cancel'),
          //           ),
          //         ],
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
