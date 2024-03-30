import 'package:cookit/components/appbar_title.dart';
import 'package:cookit/components/card.dart';
import 'package:cookit/components/loading.dart';
import 'package:cookit/models/recipe_model.dart';
import 'package:cookit/models/user_model.dart';
import 'package:cookit/screens/profile/edit_profile.dart';
import 'package:cookit/services/auth.dart';
import 'package:cookit/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

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
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Loading();
        }
        if(snapshot.hasError){
          return Center(child: Text('Sorry, an error occured, ${snapshot.error}',));
        }
        if(snapshot.hasData){
          UserData userData = snapshot.data!;

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
                    actions: const [
                      IconButton(
                        onPressed: null, 
                        icon: Icon(Icons.settings, color: Color(0xFF86BF3E),)
                      )
                    ],
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
                            const SizedBox(width: 20), 
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(userData.name,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    
                                    maxLines: null,
                                  ),
                                  const SizedBox(height: 5), 
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
                return Scaffold(
                  appBar: AppBar(
                    title: const AppbarTitle(title: 'Profile'),
                    actions: const [
                      IconButton(
                        onPressed: null, 
                        icon: Icon(Icons.settings, color: Color(0xFF86BF3E),)
                      )
                    ],
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
                            const SizedBox(width: 20), 
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(userData.name,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: null,
                                  ),
                                  const SizedBox(height: 5), 
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
                        const Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Hmm such emptyness... ', style: TextStyle(fontSize: 20.0),),
                              Text('Add your special recipes to share with others.', style: TextStyle(fontSize: 18.0),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
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