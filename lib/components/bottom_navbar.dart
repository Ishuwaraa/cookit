import 'package:cookit/screens/add_post.dart';
import 'package:cookit/screens/home.dart';
import 'package:cookit/screens/profile/profile.dart';
import 'package:cookit/screens/profile/test_profile.dart';
import 'package:cookit/screens/recipe_details.dart';
import 'package:cookit/screens/search.dart';
import 'package:cookit/screens/testHome.dart';
import 'package:cookit/screens/test_addpost.dart';
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
    // const HomePage(),
    const TestHome(),
    const SearchPage(),
    // const AddPostPage(),
    const TestAddRecipe(),
    const RecipeDetailsPage(),
    // const Profile(),
    const TestProfile(),
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
              padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
              child: Icon(Icons.home_outlined),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
              child: Icon(Icons.search),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0), 
              child: Icon(Icons.add),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
              child: Icon(Icons.favorite_border),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0), 
              child: Icon(Icons.person_outline),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
