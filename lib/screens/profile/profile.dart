import 'package:flutter/material.dart';
import 'package:mobile_application_login/components/card.dart';
import 'package:mobile_application_login/pages/edit_profile_page.dart'; // Import the necessary file containing FoodCard

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                // Profile text with larger size
                Text(
                  'Profile',
                  style: TextStyle(
                      fontSize: 32, // Increase the font size
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          actions: [
            // Settings icon
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: IconButton(
                icon: const Icon(
                  Icons.settings,
                  size: 28,
                  color: const Color(0xFF86BF3E),
                ),
                onPressed: () {
                  // Add onPressed functionality here
                },
              ),
            ),
          ],
        ),
        body: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Row(
                children: [
                  CircleAvatar(
                    // Add properties for circle avatar like radius, backgroundColor, etc.
                    radius: 60,
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1622244099803-75318348305a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80'),
                  ),
                  SizedBox(width: 20), // Add spacing between avatar and text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Chamidu Janadhara Dissanayake',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          // Set maxLines to null to allow text to wrap to multiple lines
                          maxLines: null,
                        ),
                        SizedBox(
                            height: 5), // Add spacing between name and email
                        Text(
                          'john.doe@example.com',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120.0),
              child: Row(
                children: [
                  const SizedBox(width: 5),
                  // Edit Profile
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfilePage()),
                      );
                    },
                    child: Container(
                      width: 150,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: const Color(0xFF86BF3E),
                          borderRadius: BorderRadius.circular(50)),
                      child: const Center(
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            // About Me section
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  'My Recipes',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                children: [
                  FoodCard(),
                  const SizedBox(
                    height: 30,
                  ),
                  FoodCard(),
                  const SizedBox(
                    height: 30,
                  ),
                  FoodCard(),
                ],
              ),
            ), // Include FoodCard widget here
          ],
        ),
      ),
    );
  }
}
