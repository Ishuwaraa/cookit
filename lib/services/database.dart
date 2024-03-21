import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookit/models/user_model.dart';

class DatabaseService {

  final String userId;

  DatabaseService({required this.userId});

  //db collection ref
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  //create user document when registering
  Future updateUserData(String name, String email, String profilePicUrl) async {
    return await userCollection.doc(userId).set({
      'name': name,
      'email': email,
      'profilePic': profilePicUrl,
    });
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(userId: userId, name: snapshot.get('name'), email: snapshot.get('email'), profilePicUrl: snapshot.get('profilePic'));
  }

  //get user doc stream
  Stream<UserData> get userData {
    return userCollection.doc(userId).snapshots().map(_userDataFromSnapshot);
  }

  //update user name
  Future updateUserName(String name, String profilePicUrl) async {
    try{
      await userCollection.doc(userId).update({
        'name': name,
        'profilePic': profilePicUrl,
      });
      return true;
    }catch(e) {
      print(e.toString());
      return false;
    }
  }
}