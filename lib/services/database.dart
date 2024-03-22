import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookit/models/recipe_model.dart';
import 'package:cookit/models/user_model.dart';

class DatabaseService {

  final String userId;

  DatabaseService({required this.userId});

  //db collection ref
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference recipeCollection = FirebaseFirestore.instance.collection('recipes');

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

  //add recipe
  Future addRecipe(String recipe, String ingredients, String time, String serving, String category, String description, String photoUrl, String userId) async {
    try{
      await recipeCollection.doc().set({
        'userId': userId,
        'recipe': recipe,
        'ingredients': ingredients,
        'time': time,
        'serving': serving,
        'category': category,
        'description': description,
        'photoUrl': photoUrl,
      });
      return true;
    }catch (e) {
      print(e.toString());
      return false;
    }
  }

  //recipe list from snapshot
  List<Recipe> _recipeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Recipe(
        userId: doc.get('userId'),
        recipe: doc.get('recipe'), 
        ingredients: doc.get('ingredients'), 
        time: doc.get('time'), 
        servings: doc.get('serving'), 
        category: doc.get('category'), 
        description: doc.get('description'), 
        photoUrl: doc.get('photoUrl')
      );
    }).toList();
  }

  //get recipe list stream
  Stream<List<Recipe>> get recipes {
    return recipeCollection.snapshots().map(_recipeListFromSnapshot);
  }
}