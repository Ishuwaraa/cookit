import 'package:cookit/components/image_upload.dart';
import 'package:cookit/components/loading.dart';
import 'package:cookit/models/user_model.dart';
import 'package:cookit/screens/profile/profile_settings.dart';
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
  String imageUrl = '';

  void updateImageUrl(String newUrl) {
    setState(() {
      imageUrl = newUrl; 
    });
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserModel>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(userId: user.userId).userData,
      builder: (context, AsyncSnapshot<UserData> snapshot) {
        if(snapshot.hasError){
          return Center(child: Text('Sorry, an error occured. ${snapshot.error}'),);
        }
        if(snapshot.hasData){
          UserData userData = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              title: const Text('COOKIT'),
            ),
            body: Column(
              children: [
                Text(userData.userId),
                Text(userData.name),
                Text(userData.email),
                Text(userData.profilePicUrl),
                Text('imageUrl: $imageUrl'),
                const SizedBox(height: 20.0,),
                Container(
                  width: 200.0,
                  height: 200.0,
                  child: (imageUrl.isNotEmpty)? Image.network(imageUrl) : const Text('no image uploaded'),
                ),
                const SizedBox(height: 20.0,),
                ImageUpload(onImageUrlChange: (newUrl) {
                  updateImageUrl(newUrl);
                }),
                const SizedBox(height: 20.0,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileSettings()));
                  },
                  child: const Text('Settings page')
                ),
                ElevatedButton(
                  onPressed: () async {
                    await _auth.signOutUser();
                  }, 
                  child: const Text('Log out')),
              ],
            ),
          );
        }else{
          return const Loading();
        }
      }
    );
    
  }
}