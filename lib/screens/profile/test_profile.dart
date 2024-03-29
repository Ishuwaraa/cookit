import 'package:cookit/components/appbar_title.dart';
import 'package:cookit/components/card.dart';
import 'package:cookit/components/loading.dart';
import 'package:cookit/models/recipe_model.dart';
import 'package:cookit/models/user_model.dart';
import 'package:cookit/screens/profile/edit_profile.dart';
import 'package:cookit/services/auth.dart';
import 'package:cookit/services/database.dart';
import 'package:cookit/services/recipe_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestProfile extends StatefulWidget {
  const TestProfile({super.key});

  @override
  State<TestProfile> createState() => _TestProfileState();
}

class _TestProfileState extends State<TestProfile> {

  final AuthService _auth = AuthService();
  bool _reload = false;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserModel>(context);
    // Provider.of<RecipeStore>(context, listen: false).fetchUserRecipes(user.userId);

    return StreamBuilder<UserData>(
      stream: DatabaseService(userId: user.userId).userData,
      builder: (context, AsyncSnapshot<UserData> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Loading();
        }
        if(snapshot.hasError){
          return Center(child: Text('Sorry, an error occured, ${snapshot.error}',));
        }
        if(snapshot.hasData){
          UserData userData = snapshot.data!;
          // Provider.of<RecipeStore>(context, listen: false).fetchUserRecipes(user.userId);

          return StreamBuilder<List<Recipe>> (
            stream: DatabaseService.getuserRecipes(user.userId),
            builder: (context, snapshot) {
              if(snapshot.hasError){
                return Center(child: Text('Error: ${snapshot.hasError}'),);
              }

              final List<Recipe> recipes = snapshot.data ?? []; //empty list if data is null

              if(recipes.isNotEmpty){
                return Scaffold(
                  appBar: AppBar(
                    title: const AppbarTitle(title: 'Profile'),
                  ),
                  body: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ClipOval(
                              child: FadeInImage(
                                placeholder: const AssetImage('assets/cookit-logo.png'),
                                image: NetworkImage(userData.profilePicUrl),
                                width: 120.0,
                                height: 120.0,
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                                imageErrorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 120.0,
                                    height: 120.0,
                                    color: Colors.grey,
                                    child: const Center(child: Icon(Icons.error)),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 20), // Add spacing between avatar and text
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(userData.name,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    // Set maxLines to null to allow text to wrap to multiple lines
                                    maxLines: null,
                                  ),
                                  const SizedBox(height: 5), // Add spacing between name and email
                                  Text(userData.email,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 5.0,),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfile()));
                                    },
                                    child: Container(
                                      width: 100,
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
                                  const SizedBox(height: 5.0,),
                                  ElevatedButton(
                                    onPressed: () async {
                                      await _auth.signOutUser();
                                    }, 
                                    child: const Text('Log out')
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: recipes.length,
                            itemBuilder: (_, index) {
                              return Column(
                                children: [
                                  const SizedBox(height: 30,),
                                  FoodCard(recipes[index], type: 'profile',),
                                ],
                              );
                            },
                          )
                        ),
                      ],
                    ),
                  ),
                );
              }else{
                // return const Center(child: Text('Sorry we have trouble getting data'),);
                return const Loading();
              }
            },
          );
        }else{
          return const Loading();
        }
      },
    );
  }
}