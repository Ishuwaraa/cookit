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

      String url = 'https://firebasestorage.googleapis.com/v0/b/cookit-10505.appspot.com/o/users%2F20240402225627460996?alt=media&token=b074d7e8-a6c1-4428-8ee6-39136e035708';

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

  //forgot password
  Future forgotPassword(String email) async {
    try{
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return false;
    }
  }
}