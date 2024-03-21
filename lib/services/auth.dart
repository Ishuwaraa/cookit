import 'package:cookit/models/user_model.dart';
import 'package:cookit/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //creating a custom user object from the firebase User class
  UserModel _userFromFirebaseUser(User user){
    return UserModel(userId: user.uid); //can take the email from user.email
  }

  Stream<UserModel> get currUser {
    return _auth.authStateChanges().map((User? user) => _userFromFirebaseUser(user!));
  }

  //user register
  Future registerWithEmailAndPassword(String name, String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      String url = 'https://firebasestorage.googleapis.com/v0/b/cookit-10505.appspot.com/o/users%2F20240320194419867618?alt=media&token=4e3196fb-bca8-4af9-b424-3aa78e865606';

      //creating a new doc for the user:
      await DatabaseService(userId: user!.uid).updateUserData(name, email, url);

      return _userFromFirebaseUser(user);
    }catch (e) {
      print(e.toString());
      return null;
    }
  }

  //user login
  Future signinWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    }catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOutUser() async {
    try{
      return await _auth.signOut();
    }catch (e) {
      print(e.toString());
      return null;
    }
  }
}