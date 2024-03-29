class Recipe {

  final String userId;
  final String recipeId;
  final String recipe;
  final String ingredients;
  final String time;
  final String servings;
  final String category;
  final String description;
  final String photoUrl;
  List? comments;
  // final String isFav;
  static bool addedToFav = false;

  Recipe({
    required this.userId,
    required this.recipeId,
    required this.recipe, 
    required this.ingredients, 
    required this.time, 
    required this.servings, 
    required this.category,
    required this.description, 
    required this.photoUrl,
    this.comments,
    // required this.isFav,
  });

  static void addOrRemoveFav()  {
    addedToFav = !addedToFav;
  }

}

class UserFavRecipe {

  final String isFav;

  UserFavRecipe({required this.isFav});
}