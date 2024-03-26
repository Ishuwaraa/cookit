import 'package:cookit/components/appbar_title.dart';
import 'package:cookit/components/card.dart';
import 'package:cookit/components/loading.dart';
import 'package:cookit/models/user_model.dart';
import 'package:cookit/screens/profile/edit_profile.dart';
import 'package:cookit/screens/profile/profile_settings.dart';
import 'package:cookit/services/auth.dart';
import 'package:cookit/services/database.dart';
import 'package:cookit/services/recipe_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final AuthService _auth = AuthService();
  String imageUrl = '';
  // late UserModel _user;

  void updateImageUrl(String newUrl){
    setState(() {
      imageUrl = newUrl;
    });
  }

  // @override
  // void initState() {    
  //   super.initState();
  // }

  // @override
  // void didChangeDependencies() {
  //   _user = Provider.of<UserModel>(context, listen: false);
  //   Provider.of<RecipeStore>(context, listen: false).fetchUserRecipes(_user.userId);
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserModel>(context);
    // Provider.of<RecipeStore>(context, listen: false).fetchUserRecipes(user.userId);

    return StreamBuilder<UserData>(
      stream: DatabaseService(userId: user.userId).userData,
      builder: (context, AsyncSnapshot<UserData> snapshot) {
        if(snapshot.hasError){
          return Center(child: Text('Sorry, an error occured, ${snapshot.error}',));
        }
        if(snapshot.hasData){
          UserData userData = snapshot.data!;
          Provider.of<RecipeStore>(context, listen: false).fetchUserRecipes(user.userId);

          return DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: const AppbarTitle(title: 'Profile'),
                actions: [
                  // Settings icon
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: IconButton(
                      icon: const Icon(
                        Icons.settings,
                        size: 28,
                        color: Color(0xFF86BF3E),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder:(context) => const ProfileSettings()));
                      },
                    ),
                  ),
                ],
              ),
              body: ListView(
                children: [
                  const SizedBox(height: 20,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        // CircleAvatar(
                        //   radius: 60,
                        //   backgroundImage: 
                        //       NetworkImage(userData.profilePicUrl),
                        // ),
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
                              // Text('image: ${userData.profilePicUrl}'),
                              Text(userData.name,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                // Set maxLines to null to allow text to wrap to multiple lines
                                maxLines: null,
                              ),
                              const SizedBox(
                                  height: 5), // Add spacing between name and email
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
                  ),

                  const SizedBox(height: 20),
                  // recipe section
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
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  //   child: Column(
                  //     children: [
                  //       FoodCard(),
                  //       const SizedBox(
                  //         height: 30,
                  //       ),
                  //       FoodCard(),
                  //       const SizedBox(
                  //         height: 30,
                  //       ),
                  //       FoodCard(),
                  //     ],
                  //   ),
                  // ), // Include FoodCard widget here
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  //   child: Column(
                  //     children: [
                  //       Consumer<RecipeStore>(
                  //         builder: (context, value, child) {
                  //           return ListView.separated(
                  //             separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 30),
                  //             itemCount: value.userRecipes.length,
                  //             // itemCount: 1,
                  //             itemBuilder: (_, index) {
                  //               // return Column(
                  //               //   children: [
                  //               //     // const SizedBox(height: 30,),
                  //               //     FoodCard(value.userRecipes[index]),
                  //               //   ],
                  //               // );
                  //               return FoodCard(value.userRecipes[index]);
                            
                  //             },
                  //           );
                  //         },
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        }else{
          return const Loading();
        }
      },
    );

  }
}
