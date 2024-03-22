import 'package:cookit/components/appbar_title.dart';
import 'package:cookit/components/image_upload.dart';
import 'package:cookit/components/loading.dart';
import 'package:cookit/components/submit_button.dart';
import 'package:cookit/models/user_model.dart';
import 'package:cookit/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  bool loading = false;
  TextEditingController _editNameController = TextEditingController();
  String imageUrl = '';

  @override
  void dispose() {
    _editNameController.dispose();
    super.dispose();
  }

  void updateImageUrl(String newUrl) {
    setState(() {
      imageUrl = newUrl; 
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Press save changes to update your profile picture.'),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFF86BF3E),
      ));
      print('new image: $imageUrl');
    });
  }

  void updateName(userId, name, image) async {
    if(_editNameController.text.isNotEmpty) {
      setState(() => loading = true);
      bool result = await DatabaseService(userId: userId).updateUserName(name, image);
      print('id: $userId, name: $name, url: $imageUrl');

      if(result == false){
        setState(() => loading = false);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Could not update your details.'),
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xFF86BF3E),
        ));
      }else{
        setState(() => loading = false);
      }
      
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter your name'),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFF86BF3E),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserModel>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(userId: user.userId).userData,
      builder: (context, AsyncSnapshot<UserData> snapshot){
        if(snapshot.hasError){
          return Center(child: Text('Sorry, an error occurred. ${snapshot.error}'),);
        }
        if(snapshot.hasData){
          UserData userData = snapshot.data!;
          _editNameController = TextEditingController(text: userData.name);
          // imageUrl = userData.profilePicUrl;

          return loading? const Loading() : Scaffold(
            appBar: AppBar(
              title: const AppbarTitle(title: 'Edit Profile'),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20), // Adjust the height as needed
                  Center(
                    child: CircleAvatar(
                      radius: 90, // Adjust the size as needed
                      backgroundImage: NetworkImage(userData.profilePicUrl),
                    ),
                  ),
                  Center(
                    child: ImageUpload(onImageUrlChange: (newUrl) {
                      updateImageUrl(newUrl);
                    }),
                  ),
                  const SizedBox(
                      height: 20), // Add spacing between CircleAvatar and TextField
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: _editNameController,                      
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
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: SubmitButton(
                      onTap: () {
                        updateName(userData.userId, _editNameController.text.trim(), imageUrl);
                        // print('name: ${editNameController.text}');
                      },
                      text: 'Save Changes',
                    ),
                  ),
                ],
              ),
            ),
          );
        }else {
          return const Loading();
        }
      },
    );    
  }
}
