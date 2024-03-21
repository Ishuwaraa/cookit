import 'package:flutter/material.dart';
import 'package:mobile_application_login/components/my_button.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20), // Adjust the height as needed
            const Center(
              child: CircleAvatar(
                radius: 90, // Adjust the size as needed
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1622244099803-75318348305a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80'),
              ),
            ),
            const SizedBox(
                height: 20), // Add spacing between CircleAvatar and TextField
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                obscureText: false,
                decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors
                              .grey[400]!), // Use non-constant Color instance
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: 'Change your name',
                    hintStyle: TextStyle(color: Colors.grey[500])),
              ),
            ),
            const SizedBox(
                height: 20), // Add spacing between CircleAvatar and TextField
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                obscureText: false,
                decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors
                              .grey[400]!), // Use non-constant Color instance
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: 'Change your email',
                    hintStyle: TextStyle(color: Colors.grey[500])),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: MyButton(
                onTap: () {},
                text: 'Save Changes',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
