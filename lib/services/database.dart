import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookit/models/recipe_model.dart';
import 'package:cookit/models/user_model.dart';

class DatabaseService {

  final String userId;

  DatabaseService({required this.userId});

  //db collection ref
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  static final CollectionReference recipeCollection = FirebaseFirestore.instance.collection('recipes');

  //create user document when registering
  Future updateUserData(String name, String email, String profilePicUrl) async {
    return await userCollection.doc(userId).set({
      'name': name,
      'email': email,
      'profilePic': profilePicUrl,
      'favourites': [],
    });
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      userId: userId, 
      name: snapshot.get('name'), 
      email: snapshot.get('email'), 
      profilePicUrl: snapshot.get('profilePic'),
      favourites: snapshot.get('favourites'),
    );
  }

  //get user doc stream
  Stream<UserData> get userData {
    return userCollection.doc(userId).snapshots().map(_userDataFromSnapshot);
  }

  //update user data
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
      await recipeCollection.add({
        'userId': userId,
        'recipe': recipe,
        'ingredients': ingredients,
        'time': time,
        'serving': serving,
        'category': category,
        'description': description,
        'photoUrl': photoUrl,
      });
    }catch (e) {
      print(e.toString());
    }
  }

  static Future<bool> addRecipeUsingModel(Recipe recipe) async {
    try{
      await recipeCollection.add({
        'userId': recipe.userId,
        'recipe': recipe.recipe,
        'ingredients': recipe.ingredients,
        'time': recipe.time,
        'serving': recipe.servings,
        'category': recipe.category,
        'description': recipe.description,
        'photoUrl': recipe.photoUrl,
        'createAt': FieldValue.serverTimestamp(),
        'comments': [],
      });
      return true;
    }catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<bool> updateRecipe(Recipe recipe) async {
    try{
      await recipeCollection.doc(recipe.recipeId).update({
        'userId': recipe.userId,
        'recipe': recipe.recipe,
        'ingredients': recipe.ingredients,
        'time': recipe.time,
        'serving': recipe.servings,
        'category': recipe.category,
        'description': recipe.description,
        'photoUrl': recipe.photoUrl,
      });
      return true;
    }catch(e) {
      print(e.toString());
      return false;
    }
  }

  static Future<bool> deleteRecipe(String recipeId) async {
    try{
      await recipeCollection.doc(recipeId).delete();
      return true;
    }catch(e) {
      print(e.toString());
      return false;
    }
  }

  static Future<bool> addComment(String recipeId, String comment, String name, String image) async {
    try{
      await recipeCollection.doc(recipeId).update({
        'comments': FieldValue.arrayUnion([{
          'comment': comment, 
          'name': name,
          'image': image,
        }]),
      });
      return true;
    }catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<bool> addToFavourite(String userId, String recipeId) async {
    try{
      DatabaseService db = DatabaseService(userId: userId);
      await db.userCollection.doc(userId).update({
        'favourites': FieldValue.arrayUnion([recipeId]),
      });
      return true;
    }catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<bool> deleteFromFav(String userId, String recipeId) async {
    try{
      DatabaseService db = DatabaseService(userId: userId);
      await db.userCollection.doc(userId).update({
        'favourites': FieldValue.arrayRemove([recipeId]),
      });
      return true;
    }catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<List<dynamic>> getFavRecipeIds(String userId) async {
    try{
      DatabaseService db = DatabaseService(userId: userId);
      DocumentSnapshot userSnapshot = await db.userCollection.doc(userId).get();

      List<dynamic> favRecipeIds = userSnapshot.get('favourites');
      return favRecipeIds;
    }catch (e) {
      print(e.toString());
      return [];
    }
  }

  static Future<List<Recipe>> getFavouriteRecipes(String userId) async {
    try{
      DatabaseService db = DatabaseService(userId: userId);
      DocumentSnapshot userSnapshot = await db.userCollection.doc(userId).get();

      List<dynamic>? favouriteRecipeIds = userSnapshot.get('favourites');

      if(favouriteRecipeIds != null && favouriteRecipeIds.isNotEmpty){
        List<Recipe> favouritesRecipes = [];
        
        for(String recipeId in favouriteRecipeIds){
          DocumentSnapshot recipeSnapshot = await recipeCollection.doc(recipeId).get();
          
          if(recipeSnapshot.exists){
            List<dynamic>? commentData = recipeSnapshot.get('comments');
            List<dynamic> comments = [];

            if(commentData != null){
              comments = commentData.map((comment) => {           
                'comment': comment['comment'],
                'name': comment['name'],   
                'image': comment['image'],    
              }).toList();
            }

            Recipe recipe = Recipe(
              userId: recipeSnapshot.get('userId'), 
              recipeId: recipeSnapshot.id, 
              recipe: recipeSnapshot.get('recipe'), 
              ingredients: recipeSnapshot.get('ingredients'), 
              time: recipeSnapshot.get('time'), 
              servings: recipeSnapshot.get('serving'), 
              category: recipeSnapshot.get('category'), 
              description: recipeSnapshot.get('description'), 
              photoUrl: recipeSnapshot.get('photoUrl'),
              comments: comments,
            );

            favouritesRecipes.add(recipe);
          }
        }
        return favouritesRecipes;
      }else{
        return [];
      }
    }catch (e) {
      print(e.toString());
      return [];
    }
  }

  //get recipes once
  static Future<QuerySnapshot<Recipe>> getRecipeOnce() {
    return recipeCollection.get().then((snapshot) => snapshot as QuerySnapshot<Recipe>);
  }

  //get recipe list stream
  static Stream<List<Recipe>> get recipes {
    return recipeCollection.snapshots().map(_recipeListFromSnapshot);
  }

  //get recipe created by curruser
  static Stream<List<Recipe>> getuserRecipes(String userId) {
    return recipeCollection
      .where('userId', isEqualTo: userId)
      .snapshots().map(_recipeListFromSnapshot);
  }

  //filtered recipe - dish type
  static Stream<List<Recipe>> getFilteredRecipes(String type, String dish) {
    return recipeCollection
    .where(type, isEqualTo: dish)
    .snapshots().map(_recipeListFromSnapshot);
  }

  //recipe list from snapshot
  static List<Recipe> _recipeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      List<dynamic>? commentData = doc.get('comments');
      List<dynamic> comments = [];

      if(commentData != null){
        comments = commentData.map((comment) => {           
          'comment': comment['comment'],
          'name': comment['name'],
          'image': comment['image'],        
        }).toList();
      }

      return Recipe(
        userId: doc.get('userId'),
        recipeId: doc.id,
        recipe: doc.get('recipe'), 
        ingredients: doc.get('ingredients'), 
        time: doc.get('time'), 
        servings: doc.get('serving'), 
        category: doc.get('category'), 
        description: doc.get('description'), 
        photoUrl: doc.get('photoUrl'),
        comments: comments,
      );
    }).toList();
  }

  static Future getRecipeDetails(String id) async {
    DocumentSnapshot snapshot = await recipeCollection.doc(id).get();
    if (snapshot.exists) {
      List<dynamic>? commentData = snapshot.get('comments');
      List<dynamic> comments = [];

      if(commentData != null){
        comments = commentData.map((comment) => {           
          'comment': comment['comment'],
          'name': comment['name'], 
          'image': comment['image'],         
        }).toList();
      }

      return Recipe(
        userId: snapshot.get('userId'),
        recipeId: snapshot.id,
        recipe: snapshot.get('recipe'),
        ingredients: snapshot.get('ingredients'),
        time: snapshot.get('time'),
        servings: snapshot.get('serving'),
        category: snapshot.get('category'),
        description: snapshot.get('description'),
        photoUrl: snapshot.get('photoUrl'),
        // comments: snapshot.get('comments'),
        comments: comments,
      );
    } else {
      return null;
    }
  }

}