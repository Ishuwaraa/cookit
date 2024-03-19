import 'package:cookit/Screens/add_post_page.dart';
import 'package:cookit/Screens/home_page.dart';
import 'package:cookit/Screens/profile_page.dart';
import 'package:cookit/Screens/recipe_details.dart';
import 'package:cookit/Screens/search_page.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _HomePageState();
}

class _HomePageState extends State<BottomNavBar> {
  // Bottom nav bar
  int _selectedIndex = 0;
  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const HomePage(),
    const SearchPage(),
    const AddPostPage(),
    const ProfilePage(),
    const RecipeDetailsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF86BF3E), // Color for selected item
        unselectedItemColor: Colors.grey, // Color for unselected item
        iconSize: 35, // Increase icon size here
        items: const [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(8.0), // Add padding here
              child: Icon(Icons.home_outlined),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(8.0), // Add padding here
              child: Icon(Icons.search),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(8.0), // Add padding here
              child: Icon(Icons.add),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(8.0), // Add padding here
              child: Icon(Icons.favorite_border),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(8.0), // Add padding here
              child: Icon(Icons.person_outline),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
