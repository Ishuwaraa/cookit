import 'package:cookit/Screens/add_recipe.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cookit/models/user_model.dart';
import 'package:cookit/models/recipe_model.dart';
import 'package:cookit/services/database.dart';
import 'package:cookit/services/auth.dart';
import 'package:cookit/Screens/profile/profile_settings.dart';
import 'package:cookit/Screens/profile/edit_profile.dart';
import 'package:cookit/components/loading.dart';
import 'package:cookit/components/card.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(userId: user.userId).userData,
      builder: (context, AsyncSnapshot<UserData> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Sorry, an error occurred: ${snapshot.error}',
            ),
          );
        }
        if (snapshot.hasData) {
          UserData userData = snapshot.data!;

          return StreamBuilder<List<Recipe>>(
            stream: DatabaseService.getuserRecipes(user.userId),
            builder: (context, AsyncSnapshot<List<Recipe>> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }

              final List<Recipe> recipes = snapshot.data ?? [];

              return Scaffold(
                appBar: AppBar(
                  title: const Text('Profile'),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingsPage()),
                        );
                      },
                      icon: const Icon(
                        Icons.settings,
                        color: Color(0xFF86BF3E),
                      ),
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(userData.profilePicUrl),
                              radius: 60.0,
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userData.name,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    userData.email,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const EditProfile()),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF86BF3E),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: const Text(
                                        'Edit Profile',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () async {
                                      await _auth.signOutUser();
                                    },
                                    child: const Text('Log out'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'My Recipes',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (recipes.isNotEmpty)
                          Column(
                            children: recipes.map((recipe) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: FoodCard(recipe, type: 'profile'),
                              );
                            }).toList(),
                          )
                        else
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Center(
                                child: Text(
                                  'No recipes added yet.',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddRecipe()),
                                  );
                                },
                                child: const Text(
                                  'Add Recipe',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: const Color(0xFF86BF3E),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const Loading();
        }
      },
    );
  }
}
